package com.secplus;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

/**
 * Scheduling is on for the refresh-token sweep. Rotation writes a row per
 * refresh and the quiz flow crosses two page reloads, so the table grows
 * faster here than the word "refresh token" suggests — see AuthMaintenance.
 */
@SpringBootApplication
@EnableScheduling
public class ServerApplication {

	public static void main(String[] args) {
		SpringApplication.run(ServerApplication.class, args);
	}

}
