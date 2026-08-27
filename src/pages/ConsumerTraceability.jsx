import React, { useState } from 'react';
import { 
  ShieldCheck, AlertTriangle, Hexagon, Building, User, 
  Clipboard, FileText, ChevronDown, ChevronUp, ArrowLeft,
  CheckCircle2, XCircle, QrCode, Sparkles, MapPin, Layers,
  ExternalLink, Printer, Volume2
} from 'lucide-react';
import SpeakerButton from '../components/SpeakerButton';

export default function ConsumerTraceability({ 
  traceId, setView, harvests, batches, primaryLang = 'hi'
}) {
  const [showBlockchainDetails, setShowBlockchainDetails] = useState(false);
  const [showReportModal, setShowReportModal] = useState(false);
  const [isTampered, setIsTampered] = useState(false);

  // If no traceId provided, default to first batch for quick demo
  const effectiveTraceId = traceId || 'BT-LIC001-20260825-01';

  const isBatch = effectiveTraceId ? effectiveTraceId.startsWith('BT-') : false;
  const isHarvest = effectiveTraceId ? effectiveTraceId.startsWith('HB-') : false;

  let activeRecord = null;
  let sourceHarvestsList = [];

  if (isBatch) {
    activeRecord = batches.find(b => b.batchId === effectiveTraceId) || batches[0];
    if (activeRecord) {
      sourceHarvestsList = harvests.filter(h => activeRecord.sourceHarvestIds?.includes(h.harvestId)) || harvests;
    }
  } else if (isHarvest) {
    activeRecord = harvests.find(h => h.harvestId === effectiveTraceId) || harvests[0];
    if (activeRecord) {
      sourceHarvestsList = [activeRecord];
    }
  } else {
    activeRecord = batches[0];
    sourceHarvestsList = harvests;
  }

  // Original parameters to tamper with for SIH judging
  const originalName = activeRecord.productName || (activeRecord.flowerSources ? activeRecord.flowerSources.join(' & ') + ' Honey' : 'Pure Indian Honey');
  const originalQuantity = activeRecord.batchQuantity || "Direct Canister (150 kg)";
  const originalLab = activeRecord.labName || "Demo Honey Testing Laboratory (NABL #104)";
  
  // Tampered values when toggle is activated
  const displayName = isTampered ? `${originalName} ⚠️ [Altered / मिलावटी लेबल]` : originalName;
  const displayQuantity = isTampered ? "950 kg (Modified / वजन में हेराफेरी)" : originalQuantity;
  const displayLabStatus = isTampered ? "FAIL (Adulterated with C4 Invert Sugar)" : "100% Pure & Compliant (Verified)";
  const displayMoisture = isTampered ? "23.8% (FAIL - Limit < 20%)" : (activeRecord.moisture || "17.4% (Pass)");
  const displayC4Sugar = isTampered ? "Positive 18.2% (FAIL - Synthetic Syrup Detected)" : "Negative (Pass - No Cane/Corn Syrup)";
  const displayHash = isTampered ? "0000000000000000000000000000000000000000000000000000000000000000" : activeRecord.hash;

  return (
    <div className="consumer-layout">
      {/* Top Consumer Public Header */}
      <header className="consumer-header">
        <div className="logo-container" onClick={() => setView('landing')} style={{ cursor: 'pointer' }}>
          <span className="logo-icon">
            <Hexagon size={32} fill="#E69A10" color="#D97706" strokeWidth={2.5} />
          </span>
          <div style={{ display: 'flex', flexDirection: 'column' }}>
            <span style={{ fontSize: '1.3rem', fontWeight: 800, color: 'var(--color-text-main)', lineHeight: 1.1 }}>
              HoneyChain
            </span>
            <span style={{ fontSize: '0.72rem', color: 'var(--color-secondary-dark)', fontWeight: 700 }}>
              सत्यापित भारतीय शहद पोर्टल • Consumer Trust Guarantee
            </span>
          </div>
        </div>

        <button 
          className="btn btn-secondary btn-sm" 
          onClick={() => setView('landing')}
          style={{ fontWeight: 600, display: 'inline-flex', alignItems: 'center', gap: '0.4rem' }}
        >
          <ArrowLeft size={16} /> {primaryLang === 'hi' ? 'मुख्य पृष्ठ पर वापस' : 'Back to Home'}
        </button>
      </header>

      <div className="consumer-container">
        
        {/* 1. TOP UNMISSABLE 5-SECOND BANNER */}
        <div className={`consumer-top-banner ${isTampered ? 'banner-tampered' : 'banner-verified'}`}>
          <div className="banner-content-left">
            {isTampered ? (
              <>
                <div className="banner-icon-circle-tampered">
                  <AlertTriangle size={32} />
                </div>
                <div>
                  <h2 style={{ fontSize: '1.4rem', fontWeight: 900, color: 'var(--color-danger)', margin: 0 }}>
                    {primaryLang === 'hi' ? '⚠️ डेटा में छेड़छाड़ — शुद्धता प्रमाणपत्र अमान्य!' : '⚠️ Tamper Alert: Hash Mismatch Detected!'}
                  </h2>
                  <p style={{ margin: '0.25rem 0 0 0', fontSize: '0.9rem', color: '#7F1D1D' }}>
                    {primaryLang === 'hi' 
                      ? 'वर्तमान उत्पाद का डेटा ब्लॉकचेन में दर्ज मूल रिकॉर्ड से मेल नहीं खाता है। मिलावट का संदेह है!'
                      : 'Record values have been altered in transit and do not match the immutable blockchain ledger hash.'}
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
                      {primaryLang === 'hi' ? '✅ 100% शुद्ध एवं प्रमाणित भारतीय शहद' : '✅ Verified Authentic Indian Honey'}
                    </h2>
                    <SpeakerButton 
                      text={primaryLang === 'hi'
                        ? "सत्यापित शुद्ध भारतीय शहद। यह शहद असली किसानों की पेटियों से निकाला गया है और सरकारी लैब में शत-प्रतिशत शुद्ध पाया गया है।"
                        : "Verified authentic Indian honey. Traceable origin from genuine rural apiaries and NABL lab certified."}
                      lang={primaryLang}
                      size={20}
                    />
                  </div>
                  <p style={{ margin: '0.25rem 0 0 0', fontSize: '0.92rem', color: '#14532D', fontWeight: 600 }}>
                    {primaryLang === 'hi' 
                      ? 'HoneyChain गारंटी: खेत से जार तक हर बूँद असली और ब्लॉकचेन पर प्रमाणित।'
                      : 'HoneyChain Guarantee: Every single drop verified from village hive to your table.'}
                  </p>
                </div>
              </>
            )}
          </div>

          <div className="banner-badge-right">
            <span className="badge-tag">
              {isBatch ? 'BLENDED MASTER BATCH' : 'DIRECT SINGLE HARVEST'}
            </span>
          </div>
        </div>

        {/* 2. PRODUCT SUMMARY CARD */}
        <div className="trace-section-card" style={{ borderLeft: isTampered ? '8px solid var(--color-danger)' : '8px solid var(--color-secondary)' }}>
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', flexWrap: 'wrap', gap: '1rem', marginBottom: '1.25rem' }}>
            <div>
              <span className="field-label-tiny">
                {isBatch ? 'BATCH CODE / बारकोड' : 'HARVEST CODE / बारकोड'}
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
              <span className="badge-active" style={{ backgroundColor: '#DCFCE7', color: '#15803D', fontSize: '0.75rem', marginTop: '0.35rem' }}>
                ✓ NABL Tested
              </span>
            </div>
          </div>

          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '1.5rem', borderTop: '1px solid var(--color-border)', paddingTop: '1.25rem' }}>
            <div>
              <span className="field-label-tiny">{primaryLang === 'hi' ? 'कंपनी / एफपीओ' : 'Processing Brand / FPO'}</span>
              <strong style={{ fontSize: '1.05rem' }}>{activeRecord.companyName || 'Farmer Direct Store'}</strong>
            </div>
            <div>
              <span className="field-label-tiny">{primaryLang === 'hi' ? 'लाइसेंस प्रमाण' : 'FSSAI License'}</span>
              <strong style={{ fontSize: '1.05rem', color: 'var(--color-secondary-dark)' }}>{activeRecord.fssaiNumber || activeRecord.licenseNumber || 'FSSAI 10021051000124'}</strong>
            </div>
            <div>
              <span className="field-label-tiny">{primaryLang === 'hi' ? 'कुल बैच मात्रा' : 'Net Batch Volume'}</span>
              <strong style={{ fontSize: '1.05rem', color: isTampered ? 'var(--color-danger)' : 'inherit' }}>{displayQuantity}</strong>
            </div>
          </div>
        </div>

        {/* 3. VISUAL ORIGIN CHAIN FLOW (Vertical timeline with icons) */}
        <section className="trace-section-card">
          <div style={{ display: 'flex', alignItems: 'center', gap: '0.6rem', marginBottom: '1.25rem' }}>
            <h3 style={{ fontSize: '1.3rem', fontWeight: 800, margin: 0 }}>
              {primaryLang === 'hi' ? 'खेत से जार तक का सफ़र (Origin Chain Flow)' : 'Farm-to-Jar Origin Trail'}
            </h3>
            <SpeakerButton 
              text={primaryLang === 'hi' 
                ? "खेत से जार तक का सफ़र। नीचे दी गई टाइमलाइन में देखें कि यह शहद किस किसान के खेत से निकली, किस लैब में जाँची गई और कैसे पैक हुई।"
                : "Origin trail timeline. See every stage from village beekeepers to lab testing and final bottling."}
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
                  {primaryLang === 'hi' ? '1. स्वतंत्र किसान स्रोत' : '1. Rural Beekeeper Origin'}
                </div>
                <p className="timeline-desc">
                  <strong>रवि कुमार (Rampur, UP)</strong> + <strong>अमित सिंह (Alwar, Rajasthan)</strong> — मधुक्रांति पंजीकृत किसानों द्वारा प्राकृतिक मधुमक्खी पेटियों से संकलित।
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
                  {primaryLang === 'hi' ? '2. कच्ची शहद निकालाई रिकॉर्ड' : '2. Raw Harvest Logging'}
                </div>
                <p className="timeline-desc">
                  सरसों एवं बहुपुष्पी फूलों का रस, 100% प्राकृतिक छत्ते से निकाला गया। कोई कृत्रिम शर्करा नहीं।
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
                  {primaryLang === 'hi' ? '3. NABL लैब शुद्धता जाँच #104' : '3. NABL Accredited Lab Testing'}
                </div>
                <p className="timeline-desc">
                  नमी 17.4% (मानक &lt;20%), C4 इनवर्ट शुगर नेगेटिव (पास), भारी धातु रहित।
                </p>
              </div>
            </div>

            {/* Step 4: Company */}
            <div className="timeline-node">
              <div className="timeline-icon-box" style={{ backgroundColor: '#FEF3C7', color: '#D97706' }}>
                🏭
              </div>
              <div className="timeline-content">
                <div className="timeline-title">
                  {primaryLang === 'hi' ? '4. ब्लेंडिंग एवं जार पैकेजिंग' : '4. Cold-Filtered & Bottled'}
                </div>
                <p className="timeline-desc">
                  <strong>ABC Honey Producers Pvt Ltd</strong> द्वारा कम तापमान (&lt;40°C) पर छाना गया ताकि प्राकृतिक एंजाइम और परागकण सुरक्षित रहें।
                </p>
              </div>
            </div>

            {/* Step 5: Blockchain */}
            <div className="timeline-node">
              <div className="timeline-icon-box" style={{ backgroundColor: isTampered ? '#FEE2E2' : '#F3E8FF', color: isTampered ? '#DC2626' : '#7C3AED' }}>
                ⛓️
              </div>
              <div className="timeline-content">
                <div className="timeline-title">
                  {primaryLang === 'hi' ? '5. हनीचेन ब्लॉकचेन लेजर कमिट' : '5. HoneyChain Cryptographic Commitment'}
                </div>
                <p className="timeline-desc">
                  ब्लॉक #{activeRecord.blockNumber || 148920} पर SHA-256 अपरिवर्तनीय हैश रिकॉर्ड दर्ज।
                </p>
              </div>
            </div>
          </div>
        </section>

        {/* 4. SOURCE BEEKEEPERS (Putting human faces to the honey) */}
        <section className="trace-section-card">
          <div style={{ display: 'flex', alignItems: 'center', gap: '0.6rem', marginBottom: '1.25rem' }}>
            <h3 style={{ fontSize: '1.3rem', fontWeight: 800, margin: 0 }}>
              {primaryLang === 'hi' ? 'हमारे मेहनती किसान (Source Beekeepers)' : 'Source Beekeepers'}
            </h3>
            <SpeakerButton 
              text={primaryLang === 'hi' 
                ? "शहद के स्रोत किसान। जानिए उन किसानों के बारे में जिन्होंने इस शहद का उत्पादन किया।"
                : "Source beekeepers who produced this honey in their village apiaries."}
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
                    <span>{primaryLang === 'hi' ? 'फूल का प्रकार:' : 'Flora:'}</span>
                    <strong>🌼 {h.flowerSources.join(', ')}</strong>
                  </div>
                  <div className="farmer-detail-item">
                    <span>{primaryLang === 'hi' ? 'निकालाई तारीख:' : 'Harvest Date:'}</span>
                    <strong>{h.harvestDate}</strong>
                  </div>
                </div>

                <div className="farmer-trust-footer">
                  <span className="badge-active" style={{ backgroundColor: '#DCFCE7', color: '#15803D', fontWeight: 700, fontSize: '0.78rem' }}>
                    🟢 ✓ 100% Farmer Provenance Verified
                  </span>
                </div>
              </div>
            ))}
          </div>
        </section>

        {/* 5. LAB INSPECTION SCORECARD (Moisture, HMF, Pollen, C4 Sugar) */}
        <section className="trace-section-card">
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.25rem', flexWrap: 'wrap', gap: '0.5rem' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '0.6rem' }}>
              <h3 style={{ fontSize: '1.3rem', fontWeight: 800, margin: 0 }}>
                {primaryLang === 'hi' ? 'सरकारी लैब शुद्धता स्कोरकार्ड' : 'Laboratory Purity Scorecard'}
              </h3>
              <SpeakerButton 
                text={primaryLang === 'hi' 
                  ? "लैब शुद्धता स्कोरकार्ड। सभी मानक जैसे नमी और सुक्रोज सरकारी FSSAI मानकों के अनुरूप उत्तीर्ण हैं।"
                  : "Laboratory purity scorecard showing moisture, C4 sugar screen, and pollen indices compliance."}
                lang={primaryLang}
                size={18}
              />
            </div>

            <button 
              className="btn btn-secondary btn-sm" 
              onClick={() => setShowReportModal(true)}
              style={{ fontWeight: 700 }}
            >
              <FileText size={16} /> {primaryLang === 'hi' ? 'सरकारी रिपोर्ट देखें (PDF)' : 'View Lab Report'}
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
              <div className="scorecard-limit">{primaryLang === 'hi' ? 'मानक: 80 mg/kg से कम (अत्यधिक ताजा)' : 'Limit: < 80 mg/kg (Fresh)'}</div>
            </div>

            {/* Pollen Count */}
            <div className="scorecard-item item-pass">
              <div className="scorecard-top">
                <span className="scorecard-title">{primaryLang === 'hi' ? 'प्राकृतिक परागकण (Pollen Count)' : 'Pollen Grain Density'}</span>
                <span className="badge-score badge-pass">PASS 🟢</span>
              </div>
              <div className="scorecard-val">19,400 grains/g</div>
              <div className="scorecard-limit">{primaryLang === 'hi' ? 'मानक: शुद्ध प्राकृतिक छत्ते का पराग' : 'Standard: Natural Flora Intact'}</div>
            </div>
          </div>
        </section>

        {/* 6. BLOCKCHAIN INTEGRITY DRAWER */}
        <section className="trace-section-card">
          <div 
            className="blockchain-drawer-header"
            onClick={() => setShowBlockchainDetails(!showBlockchainDetails)}
            style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', cursor: 'pointer' }}
          >
            <div style={{ display: 'flex', alignItems: 'center', gap: '0.6rem' }}>
              <ShieldCheck size={24} style={{ color: isTampered ? 'var(--color-danger)' : 'var(--color-accent)' }} />
              <div>
                <h3 style={{ fontSize: '1.25rem', fontWeight: 800, margin: 0 }}>
                  {primaryLang === 'hi' ? 'ब्लॉकचेन अपरिवर्तनीयता विवरण (Technical Ledger)' : 'Blockchain Immutability Ledger'}
                </h3>
                <span style={{ fontSize: '0.8rem', color: 'var(--color-text-muted)' }}>
                  {primaryLang === 'hi' ? 'तकनीकी विवरण देखने के लिए क्लिक करें' : 'Click to inspect cryptographic hash block'}
                </span>
              </div>
            </div>

            <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem' }}>
              <span className="badge-active" style={{ 
                backgroundColor: isTampered ? 'var(--color-danger-light)' : '#F3E8FF',
                color: isTampered ? 'var(--color-danger)' : '#7C3AED',
                fontWeight: 800
              }}>
                {isTampered ? '⚠️ Hash Mismatch' : '🟢 Block #148920 Verified'}
              </span>
              {showBlockchainDetails ? <ChevronUp size={22} /> : <ChevronDown size={22} />}
            </div>
          </div>

          {showBlockchainDetails && (
            <div className="blockchain-drawer-content" style={{ marginTop: '1.5rem', padding: '1.5rem', backgroundColor: '#FDFBF7', borderRadius: 'var(--radius-md)', border: '1px solid var(--color-border)' }}>
              <div className="blockchain-row">
                <span className="blockchain-label">CURRENT DATA BLOCK HASH (SHA-256):</span>
                <code className="blockchain-val" style={{ color: isTampered ? 'var(--color-danger)' : 'var(--color-primary-dark)' }}>
                  {displayHash}
                </code>
              </div>

              <div className="blockchain-row" style={{ marginTop: '1rem' }}>
                <span className="blockchain-label">EXPECTED COMMITMENT ON HONEYCHAIN LEDGER:</span>
                <code className="blockchain-val">
                  {activeRecord.hash}
                </code>
              </div>

              <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem', marginTop: '1.25rem', borderTop: '1px dashed var(--color-border)', paddingTop: '1rem' }}>
                <div>
                  <span className="blockchain-label">BLOCK NUMBER:</span>
                  <div style={{ fontWeight: 800, fontSize: '1rem' }}>#{activeRecord.blockNumber || 148920}</div>
                </div>
                <div>
                  <span className="blockchain-label">TIMESTAMP:</span>
                  <div style={{ fontSize: '0.9rem' }}>{activeRecord.timestamp}</div>
                </div>
              </div>
            </div>
          )}
        </section>

      </div>

      {/* Floating Demo Tamper Control Widget for SIH Judges */}
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
            ? 'इस बॉक्स को टिक करें। आप तुरंत देखेंगे कि कैसे ब्लॉकचेन हैश मिसमैच होने पर पूरा पेज लाल चेतावनी दिखाने लगता है।'
            : 'Toggle to alter data in transit. Demonstrates cryptographic hash mismatch to hackathon evaluators.'}
        </p>
      </div>

      {/* Lab Report Certificate Simulation Modal */}
      {showReportModal && (
        <div className="modal-overlay">
          <div className="modal-content" style={{ maxWidth: '650px' }}>
            <div className="modal-header">
              <h3 style={{ fontSize: '1.25rem', fontWeight: 800 }}>
                {primaryLang === 'hi' ? 'आधिकारिक NABL लैब शुद्धता प्रमाणपत्र' : 'Official NABL Purity Certificate'}
              </h3>
              <button style={{ background: 'none', border: 'none', cursor: 'pointer', fontSize: '1.2rem' }} onClick={() => setShowReportModal(false)}>
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
                  <strong>Batch Ref:</strong> {effectiveTraceId} <br />
                  <strong>Test Date:</strong> {activeRecord.createdDate || activeRecord.harvestDate}
                </div>
                <div style={{ textAlign: 'right' }}>
                  <strong>Sample Type:</strong> Raw Natural Honey <br />
                  <strong>Result:</strong> <span style={{ color: isTampered ? 'red' : 'green', fontWeight: 'bold' }}>{isTampered ? 'ADULTERATED (FAIL)' : '100% PURE (PASS)'}</span>
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

            <div className="modal-footer" style={{ marginTop: '1.25rem' }}>
              <button className="btn btn-secondary" onClick={() => setShowReportModal(false)}>
                {primaryLang === 'hi' ? 'बंद करें' : 'Close'}
              </button>
              <button className="btn btn-primary" onClick={() => alert("Report printed successfully.")}>
                <Printer size={16} /> {primaryLang === 'hi' ? 'प्रिंट करें' : 'Print Certificate'}
              </button>
            </div>
          </div>
        </div>
      )}

    </div>
  );
}
