import React from 'react';
import { ShieldCheck, Wifi, WifiOff, Globe, ArrowRight } from 'lucide-react';

export default function TopDemoBar({
  view,
  setView,
  setBeekeeperUser,
  setCompanyUser,
  setActiveTraceId,
  isOffline,
  setIsOffline,
  primaryLang,
  setPrimaryLang,
  BEEKEEPER_REGISTRY,
  LICENSE_REGISTRY
}) {
  const toggleLanguage = () => {
    setPrimaryLang(prev => (prev === 'hi' ? 'en' : 'hi'));
  };

  const handleQuickBeekeeper = () => {
    const user = BEEKEEPER_REGISTRY['BK-SYN-00001'];
    setBeekeeperUser(user);
    setView('beekeeper-dash');
  };

  const handleQuickCompany = () => {
    const comp = LICENSE_REGISTRY['LIC-SYN-00001'];
    setCompanyUser(comp);
    setView('company-dash');
  };

  const handleQuickConsumer = () => {
    setActiveTraceId('BT-LIC001-20260825-01');
    setView('consumer-trace');
  };

  return (
    <div className="sih-demo-bar">
      <div className="demo-bar-left">
        <div className="demo-tag">
          <ShieldCheck size={14} />
          <span>SIH 2026 PROTOTYPE</span>
        </div>
        <span className="demo-sep">|</span>
        <div className="demo-nav-group">
          <span className="demo-label">Quick Jump:</span>
          <button
            className={`demo-pill ${view === 'beekeeper-dash' ? 'active-pill' : ''}`}
            onClick={handleQuickBeekeeper}
            title="Switch to Beekeeper Dashboard (Ravi Kumar)"
          >
            🌾 {primaryLang === 'hi' ? 'किसान पोर्टल (रवि कुमार)' : 'Beekeeper Portal'}
          </button>
          <button
            className={`demo-pill ${view === 'company-dash' ? 'active-pill' : ''}`}
            onClick={handleQuickCompany}
            title="Switch to Company Dashboard (ABC Honey)"
          >
            🏢 {primaryLang === 'hi' ? 'कंपनी / FPO' : 'Company / FPO'}
          </button>
          <button
            className={`demo-pill ${view === 'consumer-trace' ? 'active-pill' : ''}`}
            onClick={handleQuickConsumer}
            title="Switch to Public Consumer QR Verification"
          >
            🔍 {primaryLang === 'hi' ? 'शहद जाँच (QR)' : 'Verify Honey (QR)'}
          </button>
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
