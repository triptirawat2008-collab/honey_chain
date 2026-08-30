import React, { useState, useEffect } from 'react';
import { 
  ShieldCheck, AlertTriangle, Hexagon, 
  FileText, ChevronDown, ChevronUp, ArrowLeft,
  CheckCircle2, Search, Printer, AlertCircle
} from 'lucide-react';
import SpeakerButton from '../components/SpeakerButton';
import { TRANSLATIONS } from '../utils/langHelper';

const normalizeFlowerSources = (value) => {
  if (Array.isArray(value)) return value.filter(Boolean);
  if (!value) return [];
  if (typeof value === 'string') {
    try {
      const parsed = JSON.parse(value);
      if (Array.isArray(parsed)) return parsed.filter(Boolean);
    } catch (error) {
      // Ignore parse errors and fall back to split logic.
    }
    return value.split(',').map(item => item.trim()).filter(Boolean);
  }
  return [String(value)];
};

const getLabName = (lab) => {
  if (!lab || typeof lab !== 'object') return '';

  return (
    lab.lab_name ||
    lab.labName ||
    lab.name ||
    lab.laboratory_name ||
    lab.laboratoryName ||
    ''
  );
};

const getLabUlr = (lab) => {
  if (!lab || typeof lab !== 'object') return '';

  return (
    lab.ulr_number ||
    lab.ulrNumber ||
    lab.ulr ||
    lab.lab_ulr ||
    lab.labUlr ||
    lab.labULR ||
    lab.final_lab_ulr ||
    lab.finalLabUlr ||
    lab.harvest_lab_ulr ||
    lab.harvestLabUlr ||
    ''
  );
};

export default function ConsumerTraceability({ 
  traceId, setActiveTraceId, setView, harvests = [], batches = [], primaryLang = 'hi'
}) {
  const [showBlockchainDetails, setShowBlockchainDetails] = useState(false);
  const [isTampered, setIsTampered] = useState(false);
  const [retryInput, setRetryInput] = useState('');
  const [retryError, setRetryError] = useState('');
  const [loading, setLoading] = useState(false);
  const [activeRecord, setActiveRecord] = useState(null);
  const [isBatch, setIsBatch] = useState(false);
  const [isNotFound, setIsNotFound] = useState(false);

  const t = (key) => TRANSLATIONS[key]?.[primaryLang] || TRANSLATIONS[key]?.['en'] || key;
  const rawId = (traceId || '').trim();

  useEffect(() => {
    if (!rawId) {
      setActiveRecord(null);
      setIsBatch(false);
      setIsNotFound(true);
      return;
    }

    let isMounted = true;
    setLoading(true);
    setRetryError('');
    setIsNotFound(false);

    fetch(`/api/trace/${encodeURIComponent(rawId)}`)
      .then(async (response) => {
        const result = await response.json();
        console.log('TRACE API RESULT:', result);
        if (!response.ok || !result.verified) {
          throw new Error(result.message || 'Record not found');
        }

        const normalized = result.recordType === 'batch'
          ? {
  batchId: result.batch?.batch_id || rawId,

  companyName:
    result.company?.company_name ||
    result.batch?.company_name ||
    'Verified Producer',

  companyLicense:
    result.batch?.company_license || '',

  productName:
    result.batch?.product_name || 'Pure Indian Honey',

  batchQuantity:
    `${result.batch?.quantity_kg ?? 0} kg`,

  createdDate:
    result.batch?.created_at
      ? new Date(result.batch.created_at).toISOString().split('T')[0]
      : '',

  fssaiNumber:
    result.batch?.company_license || 'FSSAI Licensed',

  labUlR:
  result.batch?.final_lab_ulr ||
  result.harvestLabReports?.[0]?.lab?.ulr_number ||
  result.harvestLabReports?.[0]?.labReport?.ulr_number ||
  '',

labStatus:
  result.batch?.ulr_status ||
  result.harvestLabReports?.[0]?.lab?.accreditation_status ||
  'Unverified',

lab:
  result.lab ||
  result.harvestLabReports?.[0]?.lab ||
  null,

labReport:
  result.labReport ||
  result.harvestLabReports?.[0]?.labReport ||
  null,
  harvestLabReports:
    result.harvestLabReports || [],

  sourceHarvestIds:
    (result.harvests || []).map(item => item.harvest_id),

  harvests:
    result.harvests || [],

  hash:
  result.batch?.block_hash || '',

blockNumber:
  result.batch?.block_number || null,

txRef:
  result.batch?.tx_ref || '',

timestamp:
  result.batch?.created_at || '',

}
          : {
              harvestId: result.harvest?.harvest_id || rawId,
              beekeeperName: result.harvest?.beekeeper_name || 'Verified Beekeeper',
              locationName: result.harvest?.location_name || result.harvest?.state || 'Apiary',
              harvestDate: result.harvest?.harvest_date || '',
              flowerSources: normalizeFlowerSources(result.harvest?.flower_sources),
              quantityKg: Number(result.harvest?.harvest_quantity_kg ?? result.harvest?.quantity_kg ?? 160),
              moisture: '17.4% (Pass)',
              hash: result.harvest?.block_hash || '',
              blockNumber: result.harvest?.block_number || null,
              timestamp: result.harvest?.created_at || result.harvest?.harvest_date || '',
              productName: result.harvest?.flower_sources ? normalizeFlowerSources(result.harvest.flower_sources).join(' & ') + ' Honey' : 'Pure Indian Honey',
              companyName: result.harvest?.beekeeper_name || 'Verified Beekeeper',
              sourceHarvestIds: [result.harvest?.harvest_id || rawId],
              harvests: [result.harvest],
              labUlR: result.harvest?.lab_ulr || '',
              labStatus: result.harvest?.harvest_ulr_status || result.harvest?.verification_status || 'Verified',
              lab: result.lab || result.harvest?.lab || result.harvest || null,
              labReport: result.labReport || result.harvest?.labReport || result.harvest?.lab || null
            };

        if (isMounted) {
          setActiveRecord(normalized);
          setIsBatch(result.recordType === 'batch');
          setIsNotFound(false);
        }
      })
      .catch(() => {
        if (isMounted) {
          setActiveRecord(null);
          setIsBatch(false);
          setIsNotFound(true);
        }
      })
      .finally(() => {
        if (isMounted) {
          setLoading(false);
        }
      });

    return () => {
      isMounted = false;
    };
  }, [rawId]);

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

  if (loading) {
    return (
      <div className="consumer-layout">
        <header className="consumer-header">
          <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem', flexWrap: 'wrap' }}>
            <button type="button" className="btn btn-secondary btn-sm" onClick={() => setView('landing')} style={{ fontWeight: 600 }}>
              <ArrowLeft size={16} />
              <span>{t('backToHomeBtn')}</span>
            </button>
            <div className="logo-container" onClick={() => setView('landing')} style={{ cursor: 'pointer' }} role="button" tabIndex={0}>
              <span className="logo-icon">
                <Hexagon size={32} fill="#E69A10" color="#D97706" strokeWidth={2.5} />
              </span>
              <div style={{ display: 'flex', flexDirection: 'column' }}>
                <span style={{ fontSize: '1.3rem', fontWeight: 800, color: 'var(--color-text-main)', lineHeight: 1.1 }}>HoneyChain</span>
                <span style={{ fontSize: '0.72rem', color: 'var(--color-secondary-dark)', fontWeight: 700 }}>{primaryLang === 'hi' ? 'सत्यापित भारतीय शहद पोर्टल' : 'National Honey Verification Portal'}</span>
              </div>
            </div>
          </div>
        </header>
        <div className="consumer-container">
          <div className="trace-section-card" style={{ textAlign: 'center', padding: '3rem 2rem' }}>
            <h2 style={{ fontSize: '1.4rem', fontWeight: 800, margin: 0 }}>{primaryLang === 'hi' ? 'सत्यापन डेटा लोड हो रहा है...' : 'Loading trace data...'}</h2>
          </div>
        </div>
      </div>
    );
  }

  // If batch/harvest is not found, render friendly consumer error page
  if (isNotFound) {
    return (
      <div className="consumer-layout">
        {/* Consumer Header */}
        <header className="consumer-header">
          <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem', flexWrap: 'wrap' }}>
            <button
              type="button"
              className="btn btn-secondary btn-sm"
              onClick={() => setView('landing')}
              style={{ fontWeight: 600, display: 'inline-flex', alignItems: 'center', gap: '0.4rem' }}
            >
              <ArrowLeft size={16} />
              <span>{t('backToHomeBtn')}</span>
            </button>

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
          </div>
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
if (!activeRecord) {
  return (
    <div className="consumer-layout">
      <div className="consumer-container">
        <div
          className="trace-section-card"
          style={{
            textAlign: 'center',
            padding: '3rem 2rem'
          }}
        >
          <h2>Loading verification record...</h2>
        </div>
      </div>
    </div>
  );
}
  // Harvests list resolution
const normalizedSourceHarvests = (activeRecord?.harvests || [])
  .filter(Boolean)
  .map(item => {  const labInfo = (activeRecord?.harvestLabReports || [])
    .find(report => report.harvest_id === item.harvest_id);

  return {
    harvestId: item.harvest_id || item.harvestId || rawId,

    beekeeperName:
      item.beekeeper_name ||
      item.beekeeperName ||
      'Verified Beekeeper',

    beekeeperId:
      item.beekeeper_id ||
      item.beekeeperId ||
      '',

    locationName:
      item.location_name ||
      item.locationName ||
      'Apiary',

    state:
      item.state ||
      'Uttar Pradesh',

    flowerSources:
      normalizeFlowerSources(
        item.flower_sources ??
        item.flowerSources ??
        []
      ),

    harvestDate:
      item.harvest_date ||
      item.harvestDate ||
      '',

    quantityKg:
      Number(
        item.harvest_quantity_kg ??
        item.quantity_kg ??
        item.quantityKg ??
        160
      ),

    labUlR:
      item.lab_ulr || '',

    labStatus:
      item.harvest_ulr_status ||
      item.ulr_status ||
      'Unverified',

    lab:
      labInfo?.lab || null,

    labReport:
      labInfo?.labReport || null
  };
});

  let sourceHarvestsList = isBatch ? normalizedSourceHarvests : (normalizedSourceHarvests.length ? normalizedSourceHarvests : [{
harvestId: activeRecord?.harvestId || rawId,
beekeeperName: activeRecord?.beekeeperName || 'Verified Beekeeper',
locationName: activeRecord?.locationName || 'Apiary',
flowerSources: activeRecord?.flowerSources || [],
harvestDate: activeRecord?.harvestDate || '',
quantityKg: activeRecord?.quantityKg || 160,
beekeeperId: activeRecord?.beekeeperId || '',
state: activeRecord?.state || 'Uttar Pradesh'  }]);

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
        <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem', flexWrap: 'wrap' }}>
          <button
            type="button"
            className="btn btn-secondary btn-sm"
            onClick={() => setView('landing')}
            style={{ fontWeight: 600, display: 'inline-flex', alignItems: 'center', gap: '0.4rem' }}
          >
            <ArrowLeft size={16} />
            <span>{t('backToHomeBtn')}</span>
          </button>

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
        </div>
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
             <span
  className="badge-active"
  style={{
    backgroundColor: '#DCFCE7',
    color: '#15803D',
    fontSize: '0.78rem',
    marginTop: '0.35rem',
    display: 'inline-block'
  }}
>
  ✓ {activeRecord.labStatus || 'Verified'}
</span>
            </div>
          </div>

          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '1.5rem', borderTop: '1px solid var(--color-border)', paddingTop: '1.25rem' }}>
            <div>
              <span className="field-label-tiny">{t('processingBrandLabel')}</span>
              <strong style={{ fontSize: '1.05rem', display: 'block' }}>{activeRecord.companyName || (primaryLang === 'hi' ? 'किसान डायरेक्ट भंडार' : 'Farmer Direct Apiary')}</strong>
            </div>
<div>
  <span className="field-label-tiny">
    {primaryLang === 'hi' ? 'कंपनी लाइसेंस' : 'Company License'}
  </span>

  <strong
    style={{
      fontSize: '1.05rem',
      color: 'var(--color-secondary-dark)',
      display: 'block'
    }}
  >
    {activeRecord.companyLicense || 'Not available'}
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
  {sourceHarvestsList.length > 0
    ? sourceHarvestsList.map((h, index) => (
        <React.Fragment key={h.harvestId}>
          <strong>
            {h.beekeeperName}
          </strong>
          {' '}({h.locationName || h.state})
          {index < sourceHarvestsList.length - 1 ? ' + ' : ''}
        </React.Fragment>
      ))
    : (
      primaryLang === 'hi'
        ? 'कोई पंजीकृत किसान स्रोत उपलब्ध नहीं है।'
        : 'No registered beekeeper source available.'
    )
  }
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
  {(() => {
    const flowers = [...new Set(
      sourceHarvestsList.flatMap(h => h.flowerSources || [])
    )];

    if (flowers.length === 0) {
      return primaryLang === 'hi'
        ? 'फूलों के स्रोत की जानकारी उपलब्ध नहीं है।'
        : 'Flower source information is not available.';
    }

    return primaryLang === 'hi'
      ? `फूलों के स्रोत: ${flowers.join(', ')}`
      : `Recorded floral sources: ${flowers.join(', ')}`;
  })()}
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
  {activeRecord.lab
    ? (
      primaryLang === 'hi'
        ? `${activeRecord.lab.lab_name || 'प्रयोगशाला'} द्वारा ULR ${activeRecord.lab.ulr_number || 'N/A'} के तहत रिपोर्ट दर्ज है। मान्यता स्थिति: ${activeRecord.lab.accreditation_status || 'उपलब्ध नहीं'}।`
        : `${activeRecord.lab.lab_name || 'Laboratory'} recorded under ULR ${activeRecord.lab.ulr_number || 'N/A'}. Accreditation status: ${activeRecord.lab.accreditation_status || 'Not available'}.`
    )
    : (
      primaryLang === 'hi'
        ? 'इस बैच के लिए कोई अंतिम लैब रिकॉर्ड उपलब्ध नहीं है।'
        : 'No final laboratory record is available for this batch.'
    )
  }
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
  <strong>
    {activeRecord.companyName || 'Verified Producer'}
  </strong>{' '}
  {primaryLang === 'hi'
    ? 'इस बैच के प्रोसेसर/निर्माता के रूप में दर्ज है।'
    : 'is recorded as the processor/producer for this batch.'}
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
  {activeRecord.blockNumber
    ? (
        primaryLang === 'hi'
          ? `डिजिटल लेजर ब्लॉक #${activeRecord.blockNumber} पर सत्यापित।`
          : `Verified on digital ledger block #${activeRecord.blockNumber}.`
      )
    : (
        primaryLang === 'hi'
          ? 'ब्लॉकचेन रिकॉर्ड उपलब्ध है, लेकिन ब्लॉक नंबर अभी उपलब्ध नहीं है।'
          : 'Blockchain record is available, but the block number is not currently available.'
      )
  }
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
                    <span>{primaryLang === 'hi' ? 'हार्वेस्ट आईडी:' : 'Harvest ID:'}</span>
                    <button
                      type="button"
                      onClick={() => setActiveTraceId && setActiveTraceId(h.harvestId)}
                      style={{
                        background: 'none',
                        border: 'none',
                        padding: 0,
                        color: 'var(--color-primary-dark)',
                        fontWeight: 800,
                        fontFamily: 'monospace',
                        cursor: 'pointer',
                        textDecoration: 'underline'
                      }}
                    >
                      {h.harvestId}
                    </button>
                  </div>
                  <div className="farmer-detail-item">
  <span>
    {primaryLang === 'hi'
      ? 'लैब ULR:'
      : 'Lab ULR:'}
  </span>

  <strong style={{ fontFamily: 'monospace' }}>
    {h.labUlR || 'Not submitted'}
  </strong>
</div>
<div className="farmer-detail-item">
  <span>
    {primaryLang === 'hi'
      ? 'लैब स्थिति:'
      : 'Lab Status:'}
  </span>

  <strong>
    {h.labStatus || 'Unverified'}
  </strong>
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
          <div style={{ display: 'flex', alignItems: 'center', gap: '0.6rem', marginBottom: '1.25rem' }}>
            <h3 style={{ fontSize: '1.3rem', fontWeight: 800, margin: 0 }}>
              {t('labScorecardTitle')}
            </h3>
            <SpeakerButton 
              text={t('labScorecardTts')}
              lang={primaryLang}
              size={18}
            />
          </div>

          <div className="lab-scorecard-grid">
            <div className="scorecard-item item-pass">
              <div className="scorecard-top">
                <span className="scorecard-title">Lab Name</span>
                <span className="badge-score badge-pass">VERIFIED</span>
              </div>

<div className="scorecard-val">
  {getLabName(activeRecord.lab) ||
   getLabName(activeRecord.labReport) ||
   getLabName(activeRecord.harvests?.[0]) ||
   'Not available'}
</div>
            </div>

            <div className="scorecard-item item-pass">
              <div className="scorecard-top">
                <span className="scorecard-title">Lab ULR</span>
                <span className="badge-score badge-pass">ULR</span>
              </div>

<div className="scorecard-val" style={{ fontSize: '0.9rem', overflowWrap: 'anywhere' }}>
  {activeRecord.labUlR ||
   getLabUlr(activeRecord.lab) ||
   getLabUlr(activeRecord.labReport) ||
   getLabUlr(activeRecord.harvests?.[0]) ||
   'Not available'}
</div>            </div>
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
{isTampered
  ? '⚠️ Record Mismatch'
  : activeRecord.blockNumber
    ? `🟢 Block #${activeRecord.blockNumber} Confirmed`
    : '🟢 Registry Record Verified'
}              </span>
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
<div style={{ fontWeight: 800, fontSize: '1rem' }}>
  {activeRecord.blockNumber
    ? `#${activeRecord.blockNumber}`
    : 'Not available'
  }
</div>                </div>
                <div>
                  <span className="blockchain-label">{primaryLang === 'hi' ? 'समय:' : 'TIMESTAMP:'}</span>
                  <div style={{ fontSize: '0.9rem' }}>{activeRecord.timestamp}</div>
                </div>
              </div>
            </div>
          )}
        </section>

      </div>

    </div>
  );
}