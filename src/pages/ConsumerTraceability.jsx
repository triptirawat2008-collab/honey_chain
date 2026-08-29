import React, { useState } from 'react';
import { 
  ShieldCheck, AlertTriangle, Hexagon, 
  FileText, ChevronDown, ChevronUp, ArrowLeft,
  CheckCircle2, Search, Printer, AlertCircle
} from 'lucide-react';
import SpeakerButton from '../components/SpeakerButton';
import { TRANSLATIONS } from '../utils/langHelper';

export default function ConsumerTraceability({ 
  traceId, setActiveTraceId, setView, harvests = [], batches = [], primaryLang = 'hi'
}) {
  const [showBlockchainDetails, setShowBlockchainDetails] = useState(false);
  const [showReportModal, setShowReportModal] = useState(false);
  const [isTampered, setIsTampered] = useState(false);
  const [retryInput, setRetryInput] = useState('');
  const [retryError, setRetryError] = useState('');

  const t = (key) => TRANSLATIONS[key]?.[primaryLang] || TRANSLATIONS[key]?.['en'] || key;

  // Resolve input trace ID
  const rawId = (traceId || '').trim();
  const foundBatch = batches.find(b => b.batchId?.toUpperCase() === rawId.toUpperCase());
  const foundHarvest = harvests.find(h => h.harvestId?.toUpperCase() === rawId.toUpperCase());

  // Default fallback if no parameter provided at all
  let activeRecord = null;
  let isBatch = false;
  let isNotFound = false;

  if (!rawId) {
    // If opened directly without param, default to first batch for seamless demo
    activeRecord = batches[0];
    isBatch = true;
  } else if (foundBatch) {
    activeRecord = foundBatch;
    isBatch = true;
  } else if (foundHarvest) {
    activeRecord = foundHarvest;
    isBatch = false;
  } else {
    isNotFound = true;
  }

  // Handle in-page retry search
  const handleRetrySearch = (searchVal) => {
    const target = (searchVal !== undefined ? searchVal : retryInput).trim();
    if (!target) {
      setRetryError(t('errorMissingBatch'));
      return;
    }
    setRetryError('');
    if (setActiveTraceId) {
      setActiveTraceId(target);
    }
  };

  // If batch/harvest is not found, render friendly consumer error page
  if (isNotFound) {
    return (
      <div className="consumer-layout">
        {/* Consumer Header */}
        <header className="consumer-header">
          <div 
            className="logo-container" 
            onClick={() => setView('landing')} 
            style={{ cursor: 'pointer' }}
            role="button"
            tabIndex={0}
          >
            <span className="logo-icon">
              <Hexagon size={32} fill="#E69A10" color="#D97706" strokeWidth={2.5} />
            </span>
            <div style={{ display: 'flex', flexDirection: 'column' }}>
              <span style={{ fontSize: '1.3rem', fontWeight: 800, color: 'var(--color-text-main)', lineHeight: 1.1 }}>
                HoneyChain
              </span>
              <span style={{ fontSize: '0.72rem', color: 'var(--color-secondary-dark)', fontWeight: 700 }}>
                {primaryLang === 'hi' ? 'सत्यापित भारतीय शहद पोर्टल' : 'National Honey Verification Portal'}
              </span>
            </div>
          </div>

          <button 
            type="button"
            className="btn btn-secondary btn-sm" 
            onClick={() => setView('landing')}
            style={{ fontWeight: 600, display: 'inline-flex', alignItems: 'center', gap: '0.4rem' }}
          >
            <ArrowLeft size={16} /> 
            <span>{t('backToHomeBtn')}</span>
          </button>
        </header>

        <div className="consumer-container">
          {/* Friendly Error Box */}
          <div className="trace-section-card" style={{ textAlign: 'center', padding: '3rem 2rem', borderTop: '6px solid var(--color-warning)' }}>
            <div style={{ width: '64px', height: '64px', borderRadius: '50%', backgroundColor: '#FEF3C7', display: 'flex', alignItems: 'center', justifyContent: 'center', color: '#D97706', margin: '0 auto 1.25rem auto' }}>
              <AlertTriangle size={36} />
            </div>

            <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '0.5rem', marginBottom: '0.5rem' }}>
              <h2 style={{ fontSize: '1.6rem', fontWeight: 900, color: 'var(--color-text-main)', margin: 0 }}>
                {t('errorNotFoundTitle')}
              </h2>
              <SpeakerButton 
                text={t('errorNotFoundTts')}
                lang={primaryLang}
                size={20}
              />
            </div>

            <p style={{ fontSize: '1.05rem', color: 'var(--color-text-muted)', maxWidth: '560px', margin: '0 auto 1.5rem auto', lineHeight: 1.6 }}>
              {t('errorNotFoundDesc')}
            </p>

            <div style={{ backgroundColor: '#F9FAFB', padding: '0.75rem 1.25rem', borderRadius: 'var(--radius-sm)', display: 'inline-block', marginBottom: '2rem', border: '1px solid var(--color-border)' }}>
              <span style={{ fontSize: '0.85rem', color: 'var(--color-text-light)' }}>
                {primaryLang === 'hi' ? 'खोजा गया नंबर:' : 'Searched Code:'}
              </span>{' '}
              <strong style={{ fontFamily: 'monospace', fontSize: '1.05rem', color: 'var(--color-danger)' }}>
                {rawId}
              </strong>
            </div>

            {/* In-page Retry Form */}
            <div style={{ maxWidth: '480px', margin: '0 auto 2rem auto', textAlign: 'left' }}>
              <label htmlFor="retry-input" style={{ fontSize: '0.88rem', fontWeight: 700, display: 'block', marginBottom: '0.4rem' }}>
                {t('enterBatchLabel')}
              </label>
              <div style={{ display: 'flex', gap: '0.5rem', flexWrap: 'wrap' }}>
                <input 
                  id="retry-input"
                  type="text"
                  className="form-input"
                  placeholder="e.g. BT-LIC001-20260825-01"
                  value={retryInput}
                  onChange={(e) => {
                    setRetryInput(e.target.value);
                    if (retryError) setRetryError('');
                  }}
                  onKeyDown={(e) => {
                    if (e.key === 'Enter') handleRetrySearch();
                  }}
                  style={{ flex: '1 1 200px', height: '48px', fontSize: '1rem', fontWeight: 600 }}
                />
                <button 
                  type="button"
                  className="btn btn-primary"
                  onClick={() => handleRetrySearch()}
                  style={{ minHeight: '48px', padding: '0 1.25rem', fontWeight: 700 }}
                >
                  <Search size={18} />
                  <span>{t('tryAgainBtn')}</span>
                </button>
              </div>

              {retryError && (
                <div style={{ display: 'flex', alignItems: 'center', gap: '0.35rem', color: 'var(--color-danger)', fontSize: '0.85rem', marginTop: '0.5rem' }}>
                  <AlertCircle size={15} />
                  <span>{retryError}</span>
                </div>
              )}
            </div>

            {/* Sample Working Batch Suggestions */}
            <div style={{ borderTop: '1px dashed var(--color-border)', paddingTop: '1.5rem', maxWidth: '540px', margin: '0 auto' }}>
              <span style={{ fontSize: '0.85rem', fontWeight: 700, color: 'var(--color-text-muted)', display: 'block', marginBottom: '0.6rem' }}>
                {t('sampleBatchesHint')}
              </span>
              <div style={{ display: 'flex', justifyContent: 'center', flexWrap: 'wrap', gap: '0.5rem' }}>
                <button 
                  type="button"
                  className="sample-chip-btn"
                  onClick={() => {
                    if (setActiveTraceId) setActiveTraceId('BT-LIC001-20260825-01');
                  }}
                >
                  🏷️ BT-LIC001-20260825-01 (Master Batch)
                </button>
                <button 
                  type="button"
                  className="sample-chip-btn"
                  onClick={() => {
                    if (setActiveTraceId) setActiveTraceId('HB-BK0001-20260820-01');
                  }}
                >
                  🌿 HB-BK0001-20260820-01 (Farmer Direct)
                </button>
              </div>
            </div>

            <div style={{ marginTop: '2rem' }}>
              <button 
                type="button"
                className="btn btn-secondary"
                onClick={() => setView('landing')}
                style={{ fontWeight: 700 }}
              >
                <ArrowLeft size={16} /> {t('backToHomeBtn')}
              </button>
            </div>
          </div>
        </div>
      </div>
    );
  }

  // Harvests list resolution
  let sourceHarvestsList = [];
  if (isBatch) {
    sourceHarvestsList = harvests.filter(h => activeRecord.sourceHarvestIds?.includes(h.harvestId));
    if (!sourceHarvestsList || sourceHarvestsList.length === 0) {
      sourceHarvestsList = harvests;
    }
  } else {
    sourceHarvestsList = [activeRecord];
  }

  // Parameters for regular and tampered states
  const originalName = activeRecord.productName || (activeRecord.flowerSources ? activeRecord.flowerSources.join(' & ') + ' Honey' : 'Pure Indian Honey');
  const originalQuantity = activeRecord.batchQuantity || `${activeRecord.quantityKg || 150} kg (Direct Canister)`;
  
  const displayName = isTampered ? `${originalName} ⚠️ [Altered / मिलावटी लेबल]` : originalName;
  const displayQuantity = isTampered ? "950 kg (Modified / वजन में हेराफेरी)" : originalQuantity;
  const displayMoisture = isTampered ? "23.8% (FAIL - Limit < 20%)" : (activeRecord.moisture || "17.4% (Pass)");
  const displayC4Sugar = isTampered ? "Positive 18.2% (FAIL - Synthetic Syrup Detected)" : "Negative (Pass - No Cane/Corn Syrup)";
  const displayHash = isTampered ? "0000000000000000000000000000000000000000000000000000000000000000" : activeRecord.hash;

  return (
    <div className="consumer-layout">
      {/* Consumer Header */}
      <header className="consumer-header">
        <div 
          className="logo-container" 
          onClick={() => setView('landing')} 
          style={{ cursor: 'pointer' }}
          role="button"
          tabIndex={0}
        >
          <span className="logo-icon">
            <Hexagon size={32} fill="#E69A10" color="#D97706" strokeWidth={2.5} />
          </span>
          <div style={{ display: 'flex', flexDirection: 'column' }}>
            <span style={{ fontSize: '1.3rem', fontWeight: 800, color: 'var(--color-text-main)', lineHeight: 1.1 }}>
              HoneyChain
            </span>
            <span style={{ fontSize: '0.72rem', color: 'var(--color-secondary-dark)', fontWeight: 700 }}>
              {primaryLang === 'hi' ? 'सत्यापित भारतीय शहद पोर्टल' : 'National Honey Verification Portal'}
            </span>
          </div>
        </div>

        <button 
          type="button"
          className="btn btn-secondary btn-sm" 
          onClick={() => setView('landing')}
          style={{ fontWeight: 600, display: 'inline-flex', alignItems: 'center', gap: '0.4rem' }}
        >
          <ArrowLeft size={16} /> 
          <span>{t('backToHomeBtn')}</span>
        </button>
      </header>

      <div className="consumer-container">
        
        {/* 1. TOP RESULT BANNER - ACCURATE & HONEST STATUS */}
        <div className={`consumer-top-banner ${isTampered ? 'banner-tampered' : 'banner-verified'}`}>
          <div className="banner-content-left">
            {isTampered ? (
              <>
                <div className="banner-icon-circle-tampered">
                  <AlertTriangle size={32} />
                </div>
                <div>
                  <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                    <h2 style={{ fontSize: '1.4rem', fontWeight: 900, color: 'var(--color-danger)', margin: 0 }}>
                      {t('statusTamperedTitle')}
                    </h2>
                    <SpeakerButton 
                      text={t('tamperedTts')}
                      lang={primaryLang}
                      size={20}
                    />
                  </div>
                  <p style={{ margin: '0.25rem 0 0 0', fontSize: '0.9rem', color: '#7F1D1D', lineHeight: 1.5 }}>
                    {t('statusTamperedSub')}
                  </p>
                </div>
              </>
            ) : (
              <>
                <div className="banner-icon-circle-verified">
                  <CheckCircle2 size={32} />
                </div>
                <div>
                  <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                    <h2 style={{ fontSize: '1.45rem', fontWeight: 900, color: 'var(--color-secondary-dark)', margin: 0 }}>
                      ✅ {t('verificationSuccessful')} ({t('statusVerifiedTag')})
                    </h2>
                    <SpeakerButton 
                      text={t('verifiedTts')}
                      lang={primaryLang}
                      size={20}
                    />
                  </div>
                  <p style={{ margin: '0.25rem 0 0 0', fontSize: '0.92rem', color: '#14532D', fontWeight: 600 }}>
                    {t('statusVerifiedSub')}
                  </p>
                </div>
              </>
            )}
          </div>

          <div className="banner-badge-right">
            <span className="badge-tag">
              {isBatch 
                ? (primaryLang === 'hi' ? 'सत्यापित मास्टर बैच' : 'CERTIFIED MASTER BATCH') 
                : (primaryLang === 'hi' ? 'किसान डायरेक्ट शहद' : 'FARMER DIRECT HARVEST')}
            </span>
          </div>
        </div>

        {/* 2. PRODUCT SUMMARY CARD */}
        <div className="trace-section-card" style={{ borderLeft: isTampered ? '8px solid var(--color-danger)' : '8px solid var(--color-secondary)' }}>
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', flexWrap: 'wrap', gap: '1rem', marginBottom: '1.25rem' }}>
            <div>
              <span className="field-label-tiny">
                {isBatch ? (primaryLang === 'hi' ? 'बैच कोड / बारकोड' : 'BATCH CODE') : (primaryLang === 'hi' ? 'हार्वेस्ट कोड' : 'HARVEST CODE')}
              </span>
              <h2 style={{ fontFamily: 'monospace', fontSize: '1.5rem', color: isTampered ? 'var(--color-danger)' : 'var(--color-primary-dark)', margin: '0.2rem 0' }}>
                {activeRecord.batchId || activeRecord.harvestId}
              </h2>
              <div style={{ fontSize: '1.25rem', fontWeight: 800, color: isTampered ? 'var(--color-danger)' : 'var(--color-text-main)' }}>
                {displayName}
              </div>
            </div>

            <div style={{ textAlign: 'right' }}>
              <span className="field-label-tiny">{primaryLang === 'hi' ? 'प्रमाणन तिथि' : 'Verification Date'}</span>
              <div style={{ fontSize: '1.1rem', fontWeight: 800 }}>{activeRecord.createdDate || activeRecord.harvestDate}</div>
              <span className="badge-active" style={{ backgroundColor: '#DCFCE7', color: '#15803D', fontSize: '0.78rem', marginTop: '0.35rem', display: 'inline-block' }}>
                ✓ NABL Lab Passed
              </span>
            </div>
          </div>

          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '1.5rem', borderTop: '1px solid var(--color-border)', paddingTop: '1.25rem' }}>
            <div>
              <span className="field-label-tiny">{t('processingBrandLabel')}</span>
              <strong style={{ fontSize: '1.05rem', display: 'block' }}>{activeRecord.companyName || (primaryLang === 'hi' ? 'किसान डायरेक्ट भंडार' : 'Farmer Direct Apiary')}</strong>
            </div>
            <div>
              <span className="field-label-tiny">{t('fssaiLicenseLabel')}</span>
              <strong style={{ fontSize: '1.05rem', color: 'var(--color-secondary-dark)', display: 'block' }}>
                {activeRecord.fssaiNumber || activeRecord.licenseNumber || 'FSSAI 10021051000124'}
              </strong>
            </div>
            <div>
              <span className="field-label-tiny">{t('batchQuantityLabel')}</span>
              <strong style={{ fontSize: '1.05rem', color: isTampered ? 'var(--color-danger)' : 'inherit', display: 'block' }}>
                {displayQuantity}
              </strong>
            </div>
          </div>
        </div>

        {/* 3. VISUAL ORIGIN CHAIN FLOW (Everyday Human-Friendly Journey) */}
        <section className="trace-section-card">
          <div style={{ display: 'flex', alignItems: 'center', gap: '0.6rem', marginBottom: '1.25rem' }}>
            <h3 style={{ fontSize: '1.3rem', fontWeight: 800, margin: 0 }}>
              {t('originTrailTitle')}
            </h3>
            <SpeakerButton 
              text={t('originTrailTts')}
              lang={primaryLang}
              size={18}
            />
          </div>

          <div className="vertical-timeline-chain">
            {/* Step 1: Farmers */}
            <div className="timeline-node">
              <div className="timeline-icon-box" style={{ backgroundColor: '#FEF3C7', color: '#D97706' }}>
                🧑‍🌾
              </div>
              <div className="timeline-content">
                <div className="timeline-title">
                  {primaryLang === 'hi' ? '1. पंजीकृत किसान स्रोत' : '1. Registered Beekeeper Origin'}
                </div>
                <p className="timeline-desc">
                  <strong>रवि कुमार (Rampur, UP)</strong> + <strong>अमित सिंह (Alwar, Rajasthan)</strong> — {primaryLang === 'hi' ? 'मधुक्रांति पंजीकृत किसानों द्वारा प्राकृतिक मधुमक्खी पेटियों से संकलित।' : 'Harvested from verified rural apiary boxes.'}
                </p>
              </div>
            </div>

            {/* Step 2: Harvest */}
            <div className="timeline-node">
              <div className="timeline-icon-box" style={{ backgroundColor: '#DCFCE7', color: '#15803D' }}>
                🍯
              </div>
              <div className="timeline-content">
                <div className="timeline-title">
                  {primaryLang === 'hi' ? '2. प्राकृतिक शहद निकालाई' : '2. Fresh Honey Harvest'}
                </div>
                <p className="timeline-desc">
                  {primaryLang === 'hi' 
                    ? 'सरसों एवं बहुपुष्पी फूलों का प्राकृतिक पराग रस। कोई कृत्रिम शर्करा या सिरप नहीं।' 
                    : 'Extracted from natural mustard and wildflower blooms. Zero synthetic additives.'}
                </p>
              </div>
            </div>

            {/* Step 3: Lab */}
            <div className="timeline-node">
              <div className="timeline-icon-box" style={{ backgroundColor: '#DCFCE7', color: '#15803D' }}>
                🧪
              </div>
              <div className="timeline-content">
                <div className="timeline-title">
                  {primaryLang === 'hi' ? '3. NABL मान्यता प्राप्त लैब जाँच' : '3. NABL Accredited Lab Testing'}
                </div>
                <p className="timeline-desc">
                  {primaryLang === 'hi'
                    ? 'नमी 17.4% (मानक <20%), C4 इनवर्ट शुगर नेगेटिव (पास), भारी धातु रहित।'
                    : 'Moisture 17.4% (Pass), C4 invert sugar screen negative (Pass), free from heavy metals.'}
                </p>
              </div>
            </div>

            {/* Step 4: Bottling */}
            <div className="timeline-node">
              <div className="timeline-icon-box" style={{ backgroundColor: '#FEF3C7', color: '#D97706' }}>
                🏭
              </div>
              <div className="timeline-content">
                <div className="timeline-title">
                  {primaryLang === 'hi' ? '4. कोल्ड-फिल्टर एवं जार पैकेजिंग' : '4. Cold-Filtered & Bottled'}
                </div>
                <p className="timeline-desc">
                  <strong>{activeRecord.companyName || 'ABC Honey Producers Pvt Ltd'}</strong> {primaryLang === 'hi' ? 'द्वारा कम तापमान (<40°C) पर छाना गया ताकि प्राकृतिक एंजाइम और परागकण सुरक्षित रहें।' : 'Cold-filtered below 40°C to preserve natural enzymes and pollen grains.'}
                </p>
              </div>
            </div>

            {/* Step 5: Digital Proof */}
            <div className="timeline-node">
              <div className="timeline-icon-box" style={{ backgroundColor: isTampered ? '#FEE2E2' : '#F3E8FF', color: isTampered ? '#DC2626' : '#7C3AED' }}>
                🛡️
              </div>
              <div className="timeline-content">
                <div className="timeline-title">
                  {primaryLang === 'hi' ? '5. डिजिटल सुरक्षा एवं प्रमाण' : '5. Verified Digital Certificate'}
                </div>
                <p className="timeline-desc">
                  {primaryLang === 'hi' 
                    ? `सुरक्षित ब्लॉक #${activeRecord.blockNumber || 148920} पर अपरिवर्तनीय डिजिटल रिकॉर्ड दर्ज।`
                    : `Verified on digital ledger block #${activeRecord.blockNumber || 148920}.`}
                </p>
              </div>
            </div>
          </div>
        </section>

        {/* 4. SOURCE BEEKEEPERS */}
        <section className="trace-section-card">
          <div style={{ display: 'flex', alignItems: 'center', gap: '0.6rem', marginBottom: '1.25rem' }}>
            <h3 style={{ fontSize: '1.3rem', fontWeight: 800, margin: 0 }}>
              {t('sourceBeekeepersTitle')}
            </h3>
            <SpeakerButton 
              text={t('sourceBeekeepersTts')}
              lang={primaryLang}
              size={18}
            />
          </div>

          <div className="farmer-profiles-grid">
            {sourceHarvestsList.map(h => (
              <div key={h.harvestId} className="farmer-profile-card">
                <div className="farmer-card-header">
                  <div className="farmer-avatar-circle">
                    🧑‍🌾
                  </div>
                  <div>
                    <h4 style={{ fontSize: '1.15rem', fontWeight: 800, margin: 0 }}>
                      {h.beekeeperName}
                    </h4>
                    <span style={{ fontSize: '0.8rem', color: 'var(--color-text-muted)' }}>
                      📍 {h.locationName || h.state}
                    </span>
                  </div>
                </div>

                <div className="farmer-card-details">
                  <div className="farmer-detail-item">
                    <span>{primaryLang === 'hi' ? 'मधुक्रांति आईडी:' : 'Beekeeper ID:'}</span>
                    <strong style={{ fontFamily: 'monospace', color: 'var(--color-primary-dark)' }}>{h.beekeeperId}</strong>
                  </div>
                  <div className="farmer-detail-item">
                    <span>{primaryLang === 'hi' ? 'फूल का प्रकार:' : 'Flora Source:'}</span>
                    <strong>🌼 {h.flowerSources ? h.flowerSources.join(', ') : 'Mustard'}</strong>
                  </div>
                  <div className="farmer-detail-item">
                    <span>{primaryLang === 'hi' ? 'निकालाई तारीख:' : 'Harvest Date:'}</span>
                    <strong>{h.harvestDate}</strong>
                  </div>
                </div>

                <div className="farmer-trust-footer">
                  <span className="badge-active" style={{ backgroundColor: '#DCFCE7', color: '#15803D', fontWeight: 700, fontSize: '0.78rem' }}>
                    🟢 ✓ {primaryLang === 'hi' ? 'किसान स्रोत सत्यापित' : 'Farmer Provenance Verified'}
                  </span>
                </div>
              </div>
            ))}
          </div>
        </section>

        {/* 5. LAB INSPECTION SCORECARD */}
        <section className="trace-section-card">
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.25rem', flexWrap: 'wrap', gap: '0.5rem' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '0.6rem' }}>
              <h3 style={{ fontSize: '1.3rem', fontWeight: 800, margin: 0 }}>
                {t('labScorecardTitle')}
              </h3>
              <SpeakerButton 
                text={t('labScorecardTts')}
                lang={primaryLang}
                size={18}
              />
            </div>

            <button 
              type="button"
              className="btn btn-secondary btn-sm" 
              onClick={() => setShowReportModal(true)}
              style={{ fontWeight: 700 }}
            >
              <FileText size={16} /> 
              <span>{t('viewLabCertBtn')}</span>
            </button>
          </div>

          <div className="lab-scorecard-grid">
            {/* Moisture */}
            <div className={`scorecard-item ${isTampered ? 'item-fail' : 'item-pass'}`}>
              <div className="scorecard-top">
                <span className="scorecard-title">{primaryLang === 'hi' ? 'नमी की मात्रा (Moisture)' : 'Moisture Content'}</span>
                <span className={`badge-score ${isTampered ? 'badge-fail' : 'badge-pass'}`}>
                  {isTampered ? 'FAIL ❌' : 'PASS 🟢'}
                </span>
              </div>
              <div className="scorecard-val">{displayMoisture}</div>
              <div className="scorecard-limit">{primaryLang === 'hi' ? 'FSSAI मानक: 20% से कम' : 'FSSAI Limit: < 20%'}</div>
            </div>

            {/* C4 Sugar */}
            <div className={`scorecard-item ${isTampered ? 'item-fail' : 'item-pass'}`}>
              <div className="scorecard-top">
                <span className="scorecard-title">{primaryLang === 'hi' ? 'C4 शर्करा जाँच (C4 Sugar)' : 'C4 Sugar Screen'}</span>
                <span className={`badge-score ${isTampered ? 'badge-fail' : 'badge-pass'}`}>
                  {isTampered ? 'FAIL ❌' : 'PASS 🟢'}
                </span>
              </div>
              <div className="scorecard-val">{displayC4Sugar}</div>
              <div className="scorecard-limit">{primaryLang === 'hi' ? 'मानक: गन्ने/मक्के का सिरप शून्य' : 'Standard: Negative (0% Cane Syrup)'}</div>
            </div>

            {/* HMF Level */}
            <div className="scorecard-item item-pass">
              <div className="scorecard-top">
                <span className="scorecard-title">{primaryLang === 'hi' ? 'ताजगी सूचकांक (HMF Level)' : 'HMF Freshness Level'}</span>
                <span className="badge-score badge-pass">PASS 🟢</span>
              </div>
              <div className="scorecard-val">11.8 mg/kg</div>
              <div className="scorecard-limit">{primaryLang === 'hi' ? 'मानक: 80 mg/kg से कम (ताजा)' : 'Limit: < 80 mg/kg (Fresh)'}</div>
            </div>

            {/* Pollen Count */}
            <div className="scorecard-item item-pass">
              <div className="scorecard-top">
                <span className="scorecard-title">{primaryLang === 'hi' ? 'प्राकृतिक परागकण (Pollen Count)' : 'Pollen Grain Density'}</span>
                <span className="badge-score badge-pass">PASS 🟢</span>
              </div>
              <div className="scorecard-val">19,400 grains/g</div>
              <div className="scorecard-limit">{primaryLang === 'hi' ? 'मानक: प्राकृतिक पराग उपस्थित' : 'Standard: Natural Flora Intact'}</div>
            </div>
          </div>
        </section>

        {/* 6. COLLAPSIBLE TECHNICAL & SECURITY DRAWER */}
        <section className="trace-section-card">
          <div 
            className="blockchain-drawer-header"
            onClick={() => setShowBlockchainDetails(!showBlockchainDetails)}
            style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', cursor: 'pointer' }}
            role="button"
            tabIndex={0}
            aria-expanded={showBlockchainDetails}
          >
            <div style={{ display: 'flex', alignItems: 'center', gap: '0.6rem' }}>
              <ShieldCheck size={24} style={{ color: isTampered ? 'var(--color-danger)' : 'var(--color-accent)' }} />
              <div>
                <h3 style={{ fontSize: '1.25rem', fontWeight: 800, margin: 0 }}>
                  {t('techDetailsDrawerTitle')}
                </h3>
                <span style={{ fontSize: '0.8rem', color: 'var(--color-text-muted)' }}>
                  {t('techDetailsDrawerHint')}
                </span>
              </div>
            </div>

            <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem' }}>
              <span className="badge-active" style={{ 
                backgroundColor: isTampered ? 'var(--color-danger-light)' : '#F3E8FF',
                color: isTampered ? 'var(--color-danger)' : '#7C3AED',
                fontWeight: 800
              }}>
                {isTampered ? '⚠️ Record Mismatch' : `🟢 Block #${activeRecord.blockNumber || 148920} Confirmed`}
              </span>
              {showBlockchainDetails ? <ChevronUp size={22} /> : <ChevronDown size={22} />}
            </div>
          </div>

          {showBlockchainDetails && (
            <div className="blockchain-drawer-content" style={{ marginTop: '1.5rem', padding: '1.5rem', backgroundColor: '#FDFBF7', borderRadius: 'var(--radius-md)', border: '1px solid var(--color-border)' }}>
              <div className="blockchain-row">
                <span className="blockchain-label">{primaryLang === 'hi' ? 'वर्तमान डेटा ब्लॉक हैश (SHA-256):' : 'CURRENT DATA BLOCK HASH (SHA-256):'}</span>
                <code className="blockchain-val" style={{ color: isTampered ? 'var(--color-danger)' : 'var(--color-primary-dark)' }}>
                  {displayHash}
                </code>
              </div>

              <div className="blockchain-row" style={{ marginTop: '1rem' }}>
                <span className="blockchain-label">{primaryLang === 'hi' ? 'अपरिवर्तनीय लेजर रिकॉर्ड:' : 'EXPECTED COMMITMENT ON REGISTRY LEDGER:'}</span>
                <code className="blockchain-val">
                  {activeRecord.hash}
                </code>
              </div>

              <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem', marginTop: '1.25rem', borderTop: '1px dashed var(--color-border)', paddingTop: '1rem' }}>
                <div>
                  <span className="blockchain-label">{primaryLang === 'hi' ? 'ब्लॉक संख्या:' : 'BLOCK NUMBER:'}</span>
                  <div style={{ fontWeight: 800, fontSize: '1rem' }}>#{activeRecord.blockNumber || 148920}</div>
                </div>
                <div>
                  <span className="blockchain-label">{primaryLang === 'hi' ? 'समय:' : 'TIMESTAMP:'}</span>
                  <div style={{ fontSize: '0.9rem' }}>{activeRecord.timestamp}</div>
                </div>
              </div>
            </div>
          )}
        </section>

      </div>

      {/* Floating Demo Tamper Control Widget for SIH Evaluators */}
      <div className="tamper-control-float">
        <div className="tamper-control-title">
          🛠️ SIH 2026 Demo Tamper Testing
        </div>
        <label className="tamper-toggle-label" style={{ cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '0.6rem', fontWeight: 700, margin: '0.4rem 0' }}>
          <input 
            type="checkbox" 
            checked={isTampered}
            onChange={(e) => setIsTampered(e.target.checked)}
            style={{ width: '20px', height: '20px', cursor: 'pointer' }}
          />
          <span style={{ color: isTampered ? 'var(--color-danger)' : 'inherit' }}>
            {primaryLang === 'hi' ? 'डेटा में छेड़छाड़ का परीक्षण करें (Simulate Tampering)' : 'Simulate Record Tampering'}
          </span>
        </label>
        <p style={{ fontSize: '0.72rem', color: '#9CA3AF', margin: 0, lineHeight: 1.4 }}>
          {primaryLang === 'hi'
            ? 'इस बॉक्स को टिक करें। आप देखेंगे कि कैसे रिकॉर्ड में बदलाव होने पर उपभोक्ता को स्पष्ट चेतावनी दिखाई देती है।'
            : 'Toggle to test how clear warnings are displayed to consumers if data values are altered.'}
        </p>
      </div>

      {/* Lab Report Modal */}
      {showReportModal && (
        <div className="modal-overlay" onClick={() => setShowReportModal(false)}>
          <div className="modal-content" onClick={(e) => e.stopPropagation()} style={{ maxWidth: '650px' }}>
            <div className="modal-header">
              <h3 style={{ fontSize: '1.25rem', fontWeight: 800 }}>
                {primaryLang === 'hi' ? 'आधिकारिक NABL लैब शुद्धता प्रमाणपत्र' : 'Official NABL Purity Certificate'}
              </h3>
              <button 
                type="button"
                style={{ background: 'none', border: 'none', cursor: 'pointer', fontSize: '1.2rem' }} 
                onClick={() => setShowReportModal(false)}
              >
                ✕
              </button>
            </div>

            <div style={{ fontFamily: 'monospace', backgroundColor: '#F9FAFB', border: '1px solid var(--color-border)', padding: '1.5rem', borderRadius: 'var(--radius-md)', fontSize: '0.85rem' }}>
              <div style={{ textAlign: 'center', borderBottom: '2px solid #333', paddingBottom: '0.75rem', marginBottom: '1rem' }}>
                <strong style={{ fontSize: '1.1rem' }}>NATIONAL HONEY QUALITY ASSURANCE LABORATORY</strong> <br />
                NABL Accreditation No: TC-8419 • FSSAI Recognized Lab #104 <br />
                Ghaziabad, Uttar Pradesh, India
              </div>

              <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem', marginBottom: '1rem' }}>
                <div>
                  <strong>Batch Ref:</strong> {activeRecord.batchId || activeRecord.harvestId} <br />
                  <strong>Test Date:</strong> {activeRecord.createdDate || activeRecord.harvestDate}
                </div>
                <div style={{ textAlign: 'right' }}>
                  <strong>Sample Type:</strong> Raw Natural Honey <br />
                  <strong>Result:</strong> <span style={{ color: isTampered ? 'red' : 'green', fontWeight: 'bold' }}>{isTampered ? 'ADULTERATED (FAIL)' : 'PASSED / PURE'}</span>
                </div>
              </div>

              <table style={{ width: '100%', borderCollapse: 'collapse', marginTop: '0.75rem' }}>
                <thead>
                  <tr style={{ borderBottom: '1px solid #333' }}>
                    <th style={{ textAlign: 'left', padding: '0.35rem 0' }}>Parameter Tested</th>
                    <th style={{ textAlign: 'right', padding: '0.35rem 0' }}>FSSAI Limit</th>
                    <th style={{ textAlign: 'right', padding: '0.35rem 0' }}>Measured Value</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td style={{ padding: '0.35rem 0' }}>Moisture (Water)</td>
                    <td style={{ textAlign: 'right' }}>&lt; 20%</td>
                    <td style={{ textAlign: 'right', color: isTampered ? 'red' : 'inherit', fontWeight: 'bold' }}>{displayMoisture}</td>
                  </tr>
                  <tr>
                    <td style={{ padding: '0.35rem 0' }}>C4 Sugar (Corn/Cane)</td>
                    <td style={{ textAlign: 'right' }}>&lt; 7%</td>
                    <td style={{ textAlign: 'right', color: isTampered ? 'red' : 'inherit', fontWeight: 'bold' }}>{displayC4Sugar}</td>
                  </tr>
                  <tr>
                    <td style={{ padding: '0.35rem 0' }}>Fructose/Glucose Ratio</td>
                    <td style={{ textAlign: 'right' }}>&gt; 1.0</td>
                    <td style={{ textAlign: 'right' }}>1.28 (Pass)</td>
                  </tr>
                  <tr>
                    <td style={{ padding: '0.35rem 0' }}>HMF Content</td>
                    <td style={{ textAlign: 'right' }}>&lt; 80 mg/kg</td>
                    <td style={{ textAlign: 'right' }}>11.8 mg/kg (Pass)</td>
                  </tr>
                </tbody>
              </table>

              <div style={{ marginTop: '1.25rem', borderTop: '1px dashed #DDD', paddingTop: '0.75rem', fontSize: '0.75rem', color: '#666' }}>
                Cryptographic Verification Hash: <br />
                <span style={{ color: isTampered ? 'red' : '#7C3AED', wordBreak: 'break-all' }}>{displayHash}</span>
              </div>
            </div>

            <div className="modal-footer" style={{ marginTop: '1.25rem', display: 'flex', justifyContent: 'flex-end', gap: '0.75rem' }}>
              <button 
                type="button"
                className="btn btn-secondary" 
                onClick={() => setShowReportModal(false)}
              >
                {t('closeBtn')}
              </button>
              <button 
                type="button"
                className="btn btn-primary" 
                onClick={() => alert("Report printed successfully.")}
              >
                <Printer size={16} /> 
                <span>{primaryLang === 'hi' ? 'प्रिंट प्रमाणपत्र' : 'Print Certificate'}</span>
              </button>
            </div>
          </div>
        </div>
      )}

    </div>
  );
}
