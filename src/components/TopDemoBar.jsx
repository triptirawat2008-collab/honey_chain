import React from 'react';
import { ShieldCheck, Wifi, WifiOff, Globe } from 'lucide-react';

export default function TopDemoBar({
  isOffline,
  setIsOffline,
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
        {/* Network Offline Simulation Toggle */}
        <button
          className={`demo-toggle-btn ${isOffline ? 'offline-active' : 'online-active'}`}
          onClick={() => setIsOffline(!isOffline)}
          title="Simulate low connectivity / 2G village offline mode"
        >
          {isOffline ? (
            <>
              <WifiOff size={14} />
              <span>🟡 {primaryLang === 'hi' ? 'ऑफलाइन मोड (2G सिम्युलेटर)' : 'Offline Mode (2G Sync)'}</span>
            </>
          ) : (
            <>
              <Wifi size={14} />
              <span>🟢 {primaryLang === 'hi' ? 'ऑनलाइन (लाइव सिंक)' : 'Online (Live Sync)'}</span>
            </>
          )}
        </button>

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
