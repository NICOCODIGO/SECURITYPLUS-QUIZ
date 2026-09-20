package com.secplus;

import java.util.List;

import javax.sql.DataSource;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Import;
import org.springframework.jdbc.core.simple.JdbcClient;
import org.springframework.transaction.annotation.Transactional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

/**
 * Asserts that the Flyway baseline produces the schema the application
 * expects, against a real Postgres rather than an in-memory stand-in.
 *
 * The constraint tests matter more than the table list: they are the rules
 * the importer and the grading code rely on being unbreakable, and a
 * migration that quietly drops one would otherwise only surface as corrupt
 * data much later.
 */
@Import(TestcontainersConfiguration.class)
@SpringBootTest
@Transactional // rolls each test back, so the rows one test inserts cannot change another's result
class SchemaMigrationTests {

	@Autowired
	private DataSource dataSource;

	private JdbcClient db() {
		return JdbcClient.create(dataSource);
	}

	@Test
	void migrationCreatesEveryTable() {
		List<String> tables = db()
			.sql("select table_name from information_schema.tables where table_schema = 'public' order by table_name")
			.query(String.class)
			.list();

		assertThat(tables).contains(
				"attempt_answers", "attempts", "choices", "custom_quiz_presets",
				"daily_answers", "flagged_questions", "objectives", "questions",
				"refresh_tokens", "users");
	}

	@Test
	void flywayRecordsTheBaselineAsApplied() {
		Boolean success = db()
			.sql("select success from flyway_schema_history where version = '1'")
			.query(Boolean.class)
			.single();

		assertThat(success).isTrue();
	}

	@Test
	void emailUniquenessIgnoresCase() {
		db().sql("insert into users (email, password_hash) values ('Learner@Example.com', 'x')").update();

		assertThatThrownBy(() -> db()
			.sql("insert into users (email, password_hash) values ('learner@example.com', 'x')")
			.update())
			.hasMessageContaining("users_email_lower_idx");
	}

	@Test
	void aQuestionCannotHaveTwoCorrectChoices() {
		// '9.9' rather than a real code: R__seed_content.sql now populates every
		// objective in the official outline (1.1–5.6), so inserting one of those
		// here would collide with the seed instead of testing anything.
		db().sql("insert into objectives (code, domain_number, title) values ('9.9', 1, 'Test fixture')")
			.update();
		db().sql("""
				insert into questions (id, legacy_hash, text, difficulty, objective_code, filed_domain, explanation)
				values ('11111111-1111-1111-1111-111111111111', 'abc123', 'Two right answers?', 'Beginner', '9.9', 1, 'because')
				""")
			.update();
		db().sql("""
				insert into choices (question_id, position, text, is_correct)
				values ('11111111-1111-1111-1111-111111111111', 0, 'right', true)
				""")
			.update();

		assertThatThrownBy(() -> db()
			.sql("""
					insert into choices (question_id, position, text, is_correct)
					values ('11111111-1111-1111-1111-111111111111', 1, 'also right', true)
					""")
			.update())
			.hasMessageContaining("choices_one_correct_idx");
	}

	@Test
	void anAttemptRejectsAnImpossibleScore() {
		assertThatThrownBy(() -> db()
			.sql("insert into attempts (type, score, questions_count) values ('mock', 101, 90)")
			.update())
			.hasMessageContaining("attempts_score_check");
	}

	@Test
	void anAttemptMayBeAnonymous() {
		int rows = db()
			.sql("insert into attempts (user_id, type, score, questions_count) values (null, 'domain', 80, 10)")
			.update();

		assertThat(rows).isEqualTo(1);
	}
}
