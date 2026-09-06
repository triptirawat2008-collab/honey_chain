import React from 'react';
import { ShieldCheck, Globe } from 'lucide-react';

export default function TopDemoBar({
  primaryLang,
  setPrimaryLang
}) {
  const toggleLanguage = () => {
    setPrimaryLang(prev => (prev === 'hi' ? 'en' : 'hi'));
  };

  return (
    <div className="sih-demo-bar">
      <div className="demo-bar-left">
        <div className="demo-tag">
          <ShieldCheck size={14} />
          <span>HoneyChain</span>
        </div>
      </div>

      <div className="demo-bar-right">
        {/* Dual-Language Toggle (A / अ) */}
        <button
          className="demo-lang-btn"
          onClick={toggleLanguage}
          title="Toggle Primary Language (Hindi / English)"
        >
          <Globe size={14} />
          <span className="lang-text">{primaryLang === 'hi' ? 'अ / A (हिंदी मुख्य)' : 'A / अ (English Primary)'}</span>
        </button>
      </div>
    </div>
  );
}
