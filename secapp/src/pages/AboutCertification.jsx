import React from 'react';
import { Link } from 'react-router-dom';
import { createPageUrl } from "@/lib/utils";
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Shield, TrendingUp, BookOpen, Award, CheckCircle2, Clock, Users, Target } from 'lucide-react';

export default function AboutCertification() {
  const examDomains = [
    {
      number: '1.0',
      title: 'General Security Concepts',
      percentage: '12%',
      topics: [
        'Understanding different types of security controls (technical, physical, administrative)',
        'Core security principles: Confidentiality, Integrity, Availability (CIA)',
        'Authentication and authorization fundamentals',
        'Cryptography basics including encryption, hashing, and digital signatures',
      ],
    },
    {
      number: '2.0',
      title: 'Threats, Vulnerabilities, and Mitigations',
      percentage: '22%',
      topics: [
        'Identifying threat actors from nation-states to insider threats',
        'Understanding attack vectors like phishing, malware, and social engineering',
        'Recognizing vulnerabilities in applications, networks, and systems',
        'Implementing security measures to prevent and mitigate attacks',
      ],
    },
    {
      number: '3.0',
      title: 'Security Architecture',
      percentage: '18%',
      topics: [
        'Designing secure network architectures for cloud and on-premises',
        'Protecting data through encryption, classification, and access controls',
        'Building resilient systems with backups and disaster recovery plans',
        'Implementing secure infrastructure for IoT and industrial systems',
      ],
    },
    {
      number: '4.0',
      title: 'Security Operations',
      percentage: '28%',
      topics: [
        'Managing security for mobile devices, applications, and networks',
        'Monitoring and responding to security incidents effectively',
        'Implementing identity management with multi-factor authentication',
        'Using security tools like firewalls, intrusion detection, and endpoint protection',
      ],
    },
    {
      number: '5.0',
      title: 'Security Program Management and Oversight',
      percentage: '20%',
      topics: [
        'Creating security policies, procedures, and governance frameworks',
        'Assessing and managing organizational security risks',
        'Ensuring compliance with regulations and industry standards',
        'Building security awareness programs and conducting audits',
      ],
    },
  ];

  const careerBenefits = [
    { icon: TrendingUp, title: 'Higher Salary Potential', description: '130% higher median salary for tech professionals with certifications' },
    { icon: Users, title: 'In-Demand Skills', description: '7 in 10 companies recognize digital skills as critical for success' },
    { icon: Award, title: 'Industry Recognition', description: 'Globally recognized certification trusted by employers worldwide' },
    { icon: Target, title: 'Career Advancement', description: 'Opens doors to security analyst, administrator, and specialist roles' },
  ];

  const examDetails = [
    { label: 'Exam Version', value: 'V7 (SY0-701)' },
    { label: 'Questions', value: 'Maximum 90 questions' },
    { label: 'Duration', value: '90 minutes' },
    { label: 'Passing Score', value: '750 out of 900' },
    { label: 'Question Types', value: 'Multiple-choice & Performance-based' },
    { label: 'Languages', value: 'English, Japanese, Portuguese, Spanish, Thai' },
  ];

  const skillsLearned = [
    'Identify and defend against cyber threats, malware, and social engineering attacks',
    'Configure and manage security technologies including firewalls and intrusion detection systems',
    'Design secure network architectures and implement protective protocols',
    'Manage user identities, authentication methods, and access controls',
    'Assess organizational risks and develop mitigation strategies',
    'Apply encryption and cryptography to protect sensitive data',
    'Implement security policies and maintain compliance with industry standards',
  ];

  return (
    <div className="space-y-12">
      {/* Hero Section */}
      <section className="relative text-center space-y-6 py-20 rounded-2xl overflow-hidden border-2 border-red-200">
        <div className="absolute inset-0 bg-gradient-to-br from-red-600 via-slate-800 to-slate-900 opacity-95"></div>
        <div 
          className="absolute inset-0 opacity-20"
          style={{
            backgroundImage: 'url(https://images.unsplash.com/photo-1563986768609-322da13575f3?w=1200)',
            backgroundSize: 'cover',
            backgroundPosition: 'center'
          }}
        ></div>
        <div className="relative z-10 space-y-6 px-4">
          <div className="inline-flex items-center gap-2 bg-white/20 backdrop-blur-sm px-5 py-2.5 rounded-full border border-white/30">
            <Shield className="w-5 h-5 text-white" />
            <span className="text-sm font-bold text-white uppercase tracking-wide">CompTIA Security+ Certification</span>
          </div>
          
          <h1 className="text-5xl md:text-6xl font-black text-white uppercase tracking-tight">
            About the Certification
          </h1>
          
          <p className="text-xl text-white/95 max-w-3xl mx-auto leading-relaxed font-medium">
            Security+ is the industry-standard certification that validates your cybersecurity knowledge and proves you have the skills to protect organizations from threats.
          </p>
        </div>
      </section>

      {/* What is Security+ */}
      <section className="space-y-6">
        <div className="text-center">
          <h2 className="text-4xl font-black text-slate-900 uppercase tracking-tight">What is Security+?</h2>
        </div>
        
        <Card className="border-2 border-red-600 shadow-xl bg-white">
          <CardContent className="p-8 space-y-4">
            <p className="text-lg text-slate-700 leading-relaxed text-center">
              CompTIA Security+ is a globally recognized certification that establishes the foundational knowledge required to pursue a career in cybersecurity. It's the first security certification IT professionals should earn, covering essential security principles and practices.
            </p>
            <p className="text-lg text-slate-700 leading-relaxed text-center">
              This certification proves you can assess enterprise security, identify vulnerabilities, implement security solutions, and respond to incidents. It's vendor-neutral, meaning the skills you learn apply to any technology environment.
            </p>
          </CardContent>
        </Card>
      </section>

      {/* Career Benefits */}
      <section className="space-y-8">
        <Card className="border-2 border-red-600 shadow-xl rounded-3xl overflow-hidden">
          <CardContent className="p-12 space-y-8">
            <div className="text-center max-w-7xl mx-auto">
              <h2 className="text-4xl font-black text-slate-900 uppercase tracking-tight">Why Get Certified?</h2>
              <p className="text-slate-600 mt-3 text-lg font-medium">Transform your career with industry-recognized credentials</p>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 max-w-7xl mx-auto">
          {careerBenefits.map((benefit, index) => {
            const Icon = benefit.icon;
            return (
              <Card key={index} className="border-2 border-slate-200 hover:shadow-xl hover:border-red-600 transition-all bg-slate-50 rounded-2xl">
                <CardContent className="p-6 text-center space-y-3">
                  <div className="w-16 h-16 bg-red-600 rounded-xl flex items-center justify-center mx-auto shadow-lg">
                    <Icon className="w-8 h-8 text-white" />
                  </div>
                  <h3 className="font-bold text-slate-900 text-lg">{benefit.title}</h3>
                  <p className="text-sm text-slate-600 leading-relaxed">{benefit.description}</p>
                </CardContent>
              </Card>
            );
          })}
            </div>
          </CardContent>
        </Card>
      </section>

      {/* Exam Overview */}
      <Card className="border-2 border-red-600 shadow-xl bg-white">
        <CardHeader>
          <CardTitle className="text-3xl font-black text-slate-900 uppercase tracking-tight text-center">
            Exam Overview
          </CardTitle>
        </CardHeader>
        <CardContent className="space-y-6">
          <p className="text-lg text-slate-700 leading-relaxed text-center">
            The Security+ exam (SY0-701) tests your ability to perform core security functions and is required for many government and military IT positions. It's designed for professionals with 2 years of IT experience who want to specialize in security.
          </p>
          
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
            {examDetails.map((detail, index) => (
              <div key={index} className="bg-slate-50 rounded-lg p-4 border-2 border-slate-200">
                <p className="text-xs font-bold text-slate-600 uppercase tracking-wide mb-1">{detail.label}</p>
                <p className="text-lg font-bold text-slate-900">{detail.value}</p>
              </div>
            ))}
          </div>

          <div className="bg-red-50 border-2 border-red-200 rounded-lg p-6 space-y-2">
            <div className="flex items-center gap-3">
              <Clock className="w-6 h-6 text-red-600" />
              <p className="font-bold text-slate-900 text-lg">Recommended Experience</p>
            </div>
            <p className="text-slate-700 leading-relaxed">
              CompTIA Network+ certification plus two years working in a security or systems administrator role. However, with dedicated study, entry-level professionals can pass this exam.
            </p>
          </div>
        </CardContent>
      </Card>

      {/* Exam Domains */}
      <section className="space-y-6">
        <div className="text-center">
          <h2 className="text-4xl font-black text-slate-900 uppercase tracking-tight">What's on the Exam</h2>
          <p className="text-slate-600 mt-2 text-lg font-medium">Five core domains covering essential security concepts</p>
        </div>

        <div className="space-y-4">
          {examDomains.map((domain, index) => (
            <Card key={index} className="border-2 border-slate-200 hover:shadow-xl hover:border-red-600 transition-all bg-white">
              <CardHeader>
                <div className="flex items-start justify-between gap-4">
                  <div className="flex-1">
                    <div className="flex items-center gap-3 mb-2">
                      <Badge className="bg-red-600 text-white font-bold text-base py-1 px-3">
                        {domain.number}
                      </Badge>
                      <CardTitle className="text-2xl font-black text-slate-900">
                        {domain.title}
                      </CardTitle>
                    </div>
                  </div>
                  <Badge className="bg-slate-700 text-white font-bold text-lg py-2 px-4">
                    {domain.percentage}
                  </Badge>
                </div>
              </CardHeader>
              <CardContent>
                <ul className="space-y-3">
                  {domain.topics.map((topic, topicIndex) => (
                    <li key={topicIndex} className="flex items-start gap-3">
                      <CheckCircle2 className="w-5 h-5 text-red-600 flex-shrink-0 mt-0.5" />
                      <span className="text-slate-700 leading-relaxed">{topic}</span>
                    </li>
                  ))}
                </ul>
              </CardContent>
            </Card>
          ))}
        </div>
      </section>

      {/* Skills You'll Learn */}
      <section className="bg-slate-100 rounded-2xl p-12 space-y-8">
        <div className="text-left">
          <h2 className="text-3xl font-bold text-slate-900">Skills You'll Master</h2>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-4 max-w-4xl">
          {skillsLearned.map((skill, index) => (
            <div key={index} className="flex items-start gap-3">
              <div className="w-6 h-6 bg-red-600 rounded-full flex items-center justify-center flex-shrink-0 mt-1">
                <CheckCircle2 className="w-4 h-4 text-white" />
              </div>
              <span className="text-slate-900">{skill}</span>
            </div>
          ))}
        </div>
      </section>

      {/* CTA Section */}
      <Card className="border-4 border-slate-300 shadow-2xl bg-red-600">
        <CardContent className="p-12 text-white text-center space-y-6">
          <h2 className="text-4xl font-black uppercase tracking-tight">Ready to Start Your Journey?</h2>
          <p className="text-xl font-medium max-w-2xl mx-auto leading-relaxed">
            Begin learning today and earn the certification that will transform your cybersecurity career
          </p>
          <div className="flex flex-col sm:flex-row gap-4 justify-center pt-4">
            <Link to={createPageUrl('Lessons')}>
              <Button size="lg" className="bg-white text-red-600 hover:bg-slate-100 px-10 py-7 text-lg font-bold rounded-lg shadow-xl uppercase tracking-wide">
                <BookOpen className="w-5 h-5 mr-2" />
                Start Learning
              </Button>
            </Link>
            <Link to={createPageUrl('AdminContentManager')}>
              <Button size="lg" variant="outline" className="bg-transparent border-2 border-white text-white hover:bg-white/10 px-10 py-7 text-lg font-bold rounded-lg uppercase tracking-wide">
                Resources
              </Button>
            </Link>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}