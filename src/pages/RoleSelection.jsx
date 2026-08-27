import React from 'react';
import { User, Building, ArrowLeft, Hexagon, ArrowRight, ShieldCheck } from 'lucide-react';
import SpeakerButton from '../components/SpeakerButton';

export default function RoleSelection({ setView, primaryLang = 'hi' }) {
  return (
    <div className="auth-page">
      <div className="auth-container" style={{ maxWidth: '850px' }}>
        {/* Top Back Navigation */}
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2rem' }}>
          <button 
            className="btn btn-secondary" 
            onClick={() => setView('landing')} 
            style={{ display: 'inline-flex', alignItems: 'center', gap: '0.5rem', fontWeight: 600 }}
          >
            <ArrowLeft size={18} /> {primaryLang === 'hi' ? 'मुख्य पृष्ठ पर वापस' : 'Back to Home'}
          </button>

          <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
            <Hexagon size={28} fill="#E69A10" color="#D97706" strokeWidth={2.5} />
            <span style={{ fontWeight: 800, fontSize: '1.2rem' }}>HoneyChain</span>
          </div>
        </div>

        {/* Title & Audio */}
        <div style={{ textAlign: 'center', marginBottom: '2.5rem' }}>
          <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '0.75rem' }}>
            <h1 className="auth-title" style={{ fontSize: '2rem', marginBottom: 0 }}>
              {primaryLang === 'hi' ? 'अपना वर्ग चुनें' : 'Select Your Account Type'}
            </h1>
            <SpeakerButton 
              text={primaryLang === 'hi' 
                ? "अपना वर्ग चुनें। अगर आप मधुमक्खी पालक किसान हैं तो बायां कार्ड चुनें। अगर आप कंपनी या एफपीओ हैं तो दायां कार्ड चुनें।"
                : "Select your account type. Choose Individual Beekeeper for small farms, or Company and FPO for processing units."}
              lang={primaryLang}
              size={20}
            />
          </div>
          <p className="auth-subtitle" style={{ fontSize: '1.05rem', color: 'var(--color-text-muted)', marginTop: '0.5rem' }}>
            {primaryLang === 'hi'
              ? 'चुनें कि आप आज किस रूप में हनीचेन का उपयोग करना चाहते हैं'
              : 'Choose how you would like to access the HoneyChain portal today'}
          </p>
        </div>

        {/* 2 Big Role Cards */}
        <div className="role-cards-grid">
          {/* Card 1: Beekeeper */}
          <div 
            className="role-card-rural" 
            onClick={() => setView('beekeeper-verify')}
            tabIndex={0}
            role="button"
            aria-label="Continue as Beekeeper"
          >
            <div className="role-top-badge" style={{ backgroundColor: '#FEF3C7', color: '#D97706' }}>
              <span>🌾 {primaryLang === 'hi' ? 'किसानों के लिए' : 'For Beekeepers'}</span>
            </div>

            <div className="role-icon-box" style={{ backgroundColor: '#FEF3C7', color: '#D97706' }}>
              <span style={{ fontSize: '3rem' }}>🧑‍🌾</span>
            </div>

            <h3 style={{ fontSize: '1.4rem', fontWeight: 800, marginBottom: '0.25rem' }}>
              {primaryLang === 'hi' ? 'स्वतंत्र किसान / मधुमक्खी पालक' : 'Individual Beekeeper'}
            </h3>
            <div style={{ fontSize: '0.85rem', fontWeight: 600, color: 'var(--color-text-light)', marginBottom: '0.75rem' }}>
              {primaryLang === 'hi' ? 'Individual Beekeeper (5 to 50+ Hives)' : 'स्वतंत्र किसान (5 से 50+ पेटियां)'}
            </div>

            <p style={{ fontSize: '0.95rem', color: 'var(--color-text-muted)', lineHeight: 1.5, marginBottom: '1.75rem' }}>
              {primaryLang === 'hi'
                ? '5 से 50+ पेटियों वाले छोटे किसानों के लिए। अपनी पेटी की जगह, स्वास्थ्य और शहद की निकालाई को आसानी से दर्ज करें।'
                : 'For small-scale local beekeepers managing 5 to 50+ hives. Record harvests and hive locations with zero hassle.'}
            </p>

            <button className="btn btn-primary" style={{ width: '100%', minHeight: '56px', fontSize: '1.05rem', fontWeight: 800 }}>
              <span>{primaryLang === 'hi' ? 'किसान के रूप में आगे बढ़ें' : 'Continue as Beekeeper'}</span>
              <ArrowRight size={20} />
            </button>
          </div>

          {/* Card 2: Company */}
          <div 
            className="role-card-rural" 
            onClick={() => setView('company-verify')}
            tabIndex={0}
            role="button"
            aria-label="Continue as Company"
          >
            <div className="role-top-badge" style={{ backgroundColor: '#DCFCE7', color: '#15803D' }}>
              <span>🏢 {primaryLang === 'hi' ? 'कंपनी / एफपीओ' : 'For Processors'}</span>
            </div>

            <div className="role-icon-box" style={{ backgroundColor: '#DCFCE7', color: '#15803D' }}>
              <span style={{ fontSize: '3rem' }}>🏭</span>
            </div>

            <h3 style={{ fontSize: '1.4rem', fontWeight: 800, marginBottom: '0.25rem' }}>
              {primaryLang === 'hi' ? 'कंपनी / एफपीओ / प्रोसेसर' : 'Company / FPO / Processor'}
            </h3>
            <div style={{ fontSize: '0.85rem', fontWeight: 600, color: 'var(--color-text-light)', marginBottom: '0.75rem' }}>
              {primaryLang === 'hi' ? 'Honey Processing & Bottling Units' : 'कंपनी / एफपीओ / शहद प्रोसेसर्स'}
            </div>

            <p style={{ fontSize: '0.95rem', color: 'var(--color-text-muted)', lineHeight: 1.5, marginBottom: '1.75rem' }}>
              {primaryLang === 'hi'
                ? 'शहद प्रसंस्करण कंपनियों और एफपीओ के लिए। किसानों से शहद खरीदकर ब्लेंड करें और उपभोक्ता बोतलों के लिए मास्टर QR कोड बनाएं।'
                : 'For honey processing companies, cooperatives, and exporters creating traceable consumer batch jars.'}
            </p>

            <button className="btn btn-green" style={{ width: '100%', minHeight: '56px', fontSize: '1.05rem', fontWeight: 800 }}>
              <span>{primaryLang === 'hi' ? 'कंपनी / FPO के रूप में आगे बढ़ें' : 'Continue as Company'}</span>
              <ArrowRight size={20} />
            </button>
          </div>
        </div>

        {/* Prototype trust notice */}
        <div style={{ marginTop: '2.5rem', textAlign: 'center' }}>
          <span style={{ fontSize: '0.82rem', color: 'var(--color-text-muted)', display: 'inline-flex', alignItems: 'center', gap: '0.35rem' }}>
            <ShieldCheck size={14} style={{ color: 'var(--color-secondary)' }} />
            {primaryLang === 'hi' 
              ? 'प्रोटोटाइप मोड: दोनों वर्गों में जाने के लिए बिना किसी पासवर्ड के सीधा सत्यापन उपलब्ध है।'
              : 'Prototype Mode: Quick one-click verification samples are available for both account types.'}
          </span>
        </div>
      </div>
    </div>
  );
}
