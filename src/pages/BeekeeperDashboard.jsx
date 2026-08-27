import React, { useState, useEffect } from 'react';
import { 
  Hexagon, LayoutDashboard, PlusCircle, Compass, Clipboard, 
  Bell, History, LogOut, ShieldCheck, MapPin, Layers, 
  Activity, Check, FileText, Upload, Calendar, X,
  Camera, Mic, MicOff, Volume2, Sparkles, QrCode, ArrowRight,
  ArrowLeft, CheckCircle2, AlertTriangle, Printer, WifiOff, Wifi,
  ChevronRight, RefreshCw
} from 'lucide-react';
import { generateMockHash } from '../data/mockData';
import SpeakerButton from '../components/SpeakerButton';

export default function BeekeeperDashboard({ 
  user, setView, harvests, setHarvests, apiaries, setApiaries, 
  healthLogs, setHealthLogs, reminders, setReminders, history, setHistory,
  setActiveTraceId, primaryLang = 'hi', isOffline = false
}) {
  // Mobile / Sub-tab navigation: 'overview', 'harvests', 'create-harvest', 'apiaries', 'health', 'reminders', 'history'
  const [activeSubTab, setActiveSubTab] = useState('overview');
  
  // Guided Wizard Step for Create Harvest (1 to 6)
  const [wizardStep, setWizardStep] = useState(1);
  const [selectedApiaryId, setSelectedApiaryId] = useState(apiaries[0]?.locationId || 'LOC-001');
  const [harvestDate, setHarvestDate] = useState(new Date().toISOString().split('T')[0]);
  const [selectedFlowers, setSelectedFlowers] = useState(['Mustard']);
  const [customFlower, setCustomFlower] = useState('');
  const [customLocationText, setCustomLocationText] = useState('');
  const [labName, setLabName] = useState('Demo Honey Testing Laboratory (NABL #104)');
  const [labReportFile, setLabReportFile] = useState(null);
  const [labPhotoCaptured, setLabPhotoCaptured] = useState(false);
  const [gpsDetecting, setGpsDetecting] = useState(false);
  const [gpsDetected, setGpsDetected] = useState('28.8041° N, 79.0250° E (Rampur, UP)');
  
  // Verification progress simulation in step 6
  const [verificationStep, setVerificationStep] = useState(0); // 0: idle, 1: id, 2: lab, 3: report, 4: ledger, 5: done
  const [createdHarvestId, setCreatedHarvestId] = useState(null);

  // Apiary Location modal state
  const [showMoveModal, setShowMoveModal] = useState(false);
  const [activeApiaryForMove, setActiveApiaryForMove] = useState(null);
  const [moveType, setMoveType] = useState('all'); // all, some
  const [moveCount, setMoveCount] = useState(2);
  const [newGps, setNewGps] = useState('');
  const [newLocationName, setNewLocationName] = useState('');

  // Add Health Log state
  const [logApiaryId, setLogApiaryId] = useState(apiaries[0]?.locationId || 'LOC-001');
  const [logStatus, setLogStatus] = useState('Healthy');
  const [logColonies, setLogColonies] = useState(0);
  const [logNotes, setLogNotes] = useState('');
  const [isRecordingVoice, setIsRecordingVoice] = useState(false);
  const [voiceRecorded, setVoiceRecorded] = useState(false);

  // Add Reminder state
  const [newRemTitle, setNewRemTitle] = useState('');
  const [newRemDate, setNewRemDate] = useState('');
  const [newRemNotes, setNewRemNotes] = useState('');

  // Floral options with rich icons
  const flowerOptions = [
    { id: "Mustard", nameEn: "Mustard", nameHi: "सरसों", icon: "🌼" },
    { id: "Eucalyptus", nameEn: "Eucalyptus", nameHi: "यूकेलिप्टस / सफेदा", icon: "🌿" },
    { id: "Acacia", nameEn: "Acacia (Kikar)", nameHi: "किकर / बबूल", icon: "🌳" },
    { id: "Litchi", nameEn: "Litchi", nameHi: "लीची", icon: "🍒" },
    { id: "Sunflower", nameEn: "Sunflower", nameHi: "सूरजमुखी", icon: "🌻" },
    { id: "Multifloral", nameEn: "Multifloral", nameHi: "बहुपुष्पी (जंगली फूल)", icon: "💐" }
  ];

  const handleFlowerToggle = (flowerId) => {
    if (selectedFlowers.includes(flowerId)) {
      if (selectedFlowers.length > 1) {
        setSelectedFlowers(selectedFlowers.filter(f => f !== flowerId));
      }
    } else {
      setSelectedFlowers([...selectedFlowers, flowerId]);
    }
  };

  // GPS Auto-detect simulation
  const handleAutoDetectGps = () => {
    setGpsDetecting(true);
    setTimeout(() => {
      setGpsDetecting(false);
      setGpsDetected('28.8041° N, 79.0250° E (Rampur, UP - Detected via GPS)');
    }, 900);
  };

  // Voice note simulation for health log
  const handleToggleVoiceRecord = () => {
    if (!isRecordingVoice) {
      setIsRecordingVoice(true);
      setTimeout(() => {
        setIsRecordingVoice(false);
        setVoiceRecorded(true);
        setLogNotes(prev => (prev ? prev + ' ' : '') + 'बॉक्स नंबर 2 और 4 में अच्छी पराग गतिविधि देखी गई, रानी मधुमक्खी सक्रिय है।');
      }, 2500);
    } else {
      setIsRecordingVoice(false);
    }
  };

  // Start animated verification in Step 6
  const startVerificationProcess = () => {
    setWizardStep(6);
    setVerificationStep(1);
    
    setTimeout(() => {
      setVerificationStep(2);
      
      setTimeout(() => {
        setVerificationStep(3);
        
        setTimeout(() => {
          setVerificationStep(4);
          
          setTimeout(() => {
            setVerificationStep(5);
            
            // Generate Harvest ID
            const targetApiary = apiaries.find(a => a.locationId === selectedApiaryId);
            const myCount = harvests.filter(h => h.beekeeperId === user.beekeeperId).length + 1;
            const dateStr = harvestDate.replace(/-/g, '');
            const newHarvestId = `HB-BK0001-${dateStr}-0${myCount}`;
            
            const rawString = `${newHarvestId}|${user.beekeeperId}|${harvestDate}|${selectedFlowers.join(',')}`;
            const hashVal = generateMockHash(rawString);
            
            const newHarvest = {
              harvestId: newHarvestId,
              beekeeperId: user.beekeeperId,
              beekeeperName: user.registeredName,
              state: user.state || "Uttar Pradesh",
              harvestDate: harvestDate,
              flowerSources: selectedFlowers,
              flowerSourcesHi: selectedFlowers.map(f => {
                const opt = flowerOptions.find(o => o.id === f);
                return opt ? opt.nameHi : f;
              }),
              locationId: selectedApiaryId,
              locationName: customLocationText || (targetApiary ? targetApiary.name : 'Rampur Apiary'),
              gps: gpsDetected,
              labName: labName,
              labReference: "LAB-SYN-00001",
              labReportName: labReportFile ? labReportFile.name : (labPhotoCaptured ? "camera_paper_report_photo.jpg" : "lab_report_sih_demo.pdf"),
              labStatus: "Verified",
              blockchainStatus: "Verified",
              moisture: "17.4%",
              hmf: "11.2 mg/kg",
              c4Sugar: "Negative (Pass)",
              pollenCount: "19,200 grains/g",
              hash: hashVal,
              previousHash: harvests[0]?.hash || "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
              blockNumber: 148921,
              txRef: "0x" + generateMockHash(hashVal).substring(0, 60),
              timestamp: new Date().toISOString(),
              quantityKg: 160
            };

            setHarvests([newHarvest, ...harvests]);
            setCreatedHarvestId(newHarvestId);

            // Add to history
            const newHistoryItem = {
              id: `H-${Date.now()}`,
              timestamp: new Date().toISOString(),
              type: "Harvest Created",
              details: `Created Harvest ${newHarvestId} (${newHarvest.flowerSources.join('/')}) from ${newHarvest.locationName}.`
            };
            setHistory([newHistoryItem, ...history]);

          }, 900);
        }, 900);
      }, 900);
    }, 900);
  };

  const resetHarvestForm = () => {
    setWizardStep(1);
    setVerificationStep(0);
    setCreatedHarvestId(null);
    setSelectedFlowers(['Mustard']);
    setCustomFlower('');
    setCustomLocationText('');
    setLabReportFile(null);
    setLabPhotoCaptured(false);
  };

  // Move Colonies / Update Location Logic
  const handleOpenMoveModal = (apiary) => {
    setActiveApiaryForMove(apiary);
    setMoveCount(Math.min(2, apiary.hiveCount - 1 || 1));
    setMoveType('all');
    setNewGps(apiary.gps);
    setNewLocationName('');
    setShowMoveModal(true);
  };

  const handleExecuteMove = () => {
    if (!newGps) {
      alert("Please provide GPS coordinates.");
      return;
    }

    if (moveType === 'all') {
      const updatedApiaries = apiaries.map(a => {
        if (a.locationId === activeApiaryForMove.locationId) {
          return {
            ...a,
            gps: newGps,
            name: newLocationName ? newLocationName : a.name,
            lastInspection: new Date().toISOString().split('T')[0]
          };
        }
        return a;
      });
      setApiaries(updatedApiaries);

      const newHistoryItem = {
        id: `H-${Date.now()}`,
        timestamp: new Date().toISOString(),
        type: "Location Updated",
        details: `Moved ALL colonies of ${activeApiaryForMove.name} to new GPS location: ${newGps}.`
      };
      setHistory([newHistoryItem, ...history]);
    } else {
      const parsedMove = parseInt(moveCount) || 1;
      if (parsedMove >= activeApiaryForMove.hiveCount) {
        alert("To move all colonies, select 'Move all colonies'.");
        return;
      }

      const newLocId = `LOC-00${apiaries.length + 1}`;
      const newLocName = newLocationName ? newLocationName : `${activeApiaryForMove.name} (शाखा / Split)`;
      
      const newApiary = {
        locationId: newLocId,
        name: newLocName,
        gps: newGps,
        villageName: "Alwar / New Flora Migration",
        hiveCount: parsedMove,
        flora: "Mustard & Acacia (सरसों व बबूल)",
        status: activeApiaryForMove.status,
        lastInspection: new Date().toISOString().split('T')[0],
        notes: `Split from ${activeApiaryForMove.name}`
      };

      const updatedApiaries = apiaries.map(a => {
        if (a.locationId === activeApiaryForMove.locationId) {
          return {
            ...a,
            hiveCount: a.hiveCount - parsedMove,
            lastInspection: new Date().toISOString().split('T')[0]
          };
        }
        return a;
      });

      setApiaries([...updatedApiaries, newApiary]);

      const newHistoryItem = {
        id: `H-${Date.now()}`,
        timestamp: new Date().toISOString(),
        type: "Colonies Split",
        details: `Split ${parsedMove} colonies from ${activeApiaryForMove.name} and established Location: ${newLocId} at GPS: ${newGps}.`
      };
      setHistory([newHistoryItem, ...history]);
    }

    setShowMoveModal(false);
  };

  // Add Health Log Logic
  const handleAddHealthLog = (e) => {
    e.preventDefault();
    const targetApiary = apiaries.find(a => a.locationId === logApiaryId);
    if (!targetApiary) return;

    const newLog = {
      id: `HL-${Date.now()}`,
      locationId: logApiaryId,
      apiaryName: targetApiary.name,
      date: new Date().toISOString().split('T')[0],
      status: logStatus,
      statusHi: logStatus === 'Healthy' ? 'स्वस्थ (सब ठीक है)' : logStatus === 'Needs Attention' ? 'ध्यान दें (कीट/ततैया)' : 'खतरा (तुरंत ध्यान दें)',
      affectedColonies: parseInt(logColonies) || 0,
      notes: logNotes || "नियमित निरीक्षण पूर्ण। सब ठीक है।"
    };

    setHealthLogs([newLog, ...healthLogs]);

    // Update target apiary's status
    const updatedApiaries = apiaries.map(a => {
      if (a.locationId === logApiaryId) {
        return {
          ...a,
          status: logStatus,
          lastInspection: new Date().toISOString().split('T')[0]
        };
      }
      return a;
    });
    setApiaries(updatedApiaries);

    // Add to history
    const newHistoryItem = {
      id: `H-${Date.now()}`,
      timestamp: new Date().toISOString(),
      type: "Health Log Added",
      details: `Logged health for ${targetApiary.name}: ${logStatus} (${logColonies} affected boxes).`
    };
    setHistory([newHistoryItem, ...history]);

    setLogColonies(0);
    setLogNotes('');
    setVoiceRecorded(false);
    alert(primaryLang === 'hi' ? "स्वास्थ्य रिकॉर्ड सफलतापूर्वक सुरक्षित हुआ!" : "Health log saved successfully!");
  };

  // Add Reminder Logic
  const handleAddReminder = (e) => {
    e.preventDefault();
    if (!newRemTitle || !newRemDate) {
      alert("Please provide a title and date.");
      return;
    }

    const newRem = {
      id: `RM-${Date.now()}`,
      title: newRemTitle,
      date: newRemDate,
      dueDays: 2,
      urgency: "medium",
      notes: newRemNotes || "नियमित पेटी कार्य।",
      status: 'Pending'
    };

    setReminders([newRem, ...reminders]);
    setNewRemTitle('');
    setNewRemDate('');
    setNewRemNotes('');
    alert(primaryLang === 'hi' ? "कार्य अनुस्मारक जोड़ा गया!" : "Reminder added!");
  };

  const handleToggleReminder = (id) => {
    const updated = reminders.map(r => {
      if (r.id === id) {
        return { ...r, status: r.status === 'Pending' ? 'Completed' : 'Pending' };
      }
      return r;
    });
    setReminders(updated);
  };

  const myHarvests = harvests.filter(h => h.beekeeperId === user.beekeeperId);
  const totalHives = apiaries.reduce((acc, curr) => acc + curr.hiveCount, 0);

  return (
    <div className="dashboard-layout">
      {/* Desktop Sidebar */}
      <aside className="sidebar">
        <div className="sidebar-header" onClick={() => setView('landing')} style={{ cursor: 'pointer' }}>
          <Hexagon size={28} fill="#E69A10" color="#D97706" strokeWidth={2.5} />
          <div>
            <span className="sidebar-logo-text">HoneyChain</span>
            <div style={{ fontSize: '0.72rem', color: '#FEF3C7', fontWeight: 600 }}>किसान पोर्टल • Madhukranti</div>
          </div>
        </div>

        <ul className="sidebar-menu">
          <li className="sidebar-label">{primaryLang === 'hi' ? 'मुख्य मेन्यू' : 'Main Navigation'}</li>
          
          <li 
            className={`sidebar-item ${activeSubTab === 'overview' ? 'active' : ''}`}
            onClick={() => setActiveSubTab('overview')}
          >
            <LayoutDashboard size={20} />
            <span>{primaryLang === 'hi' ? 'डैशबोर्ड (Overview)' : 'Dashboard Overview'}</span>
          </li>

          <li 
            className={`sidebar-item ${activeSubTab === 'harvests' ? 'active' : ''}`}
            onClick={() => setActiveSubTab('harvests')}
          >
            <span style={{ fontSize: '1.2rem', marginRight: '4px' }}>🍯</span>
            <span>{primaryLang === 'hi' ? 'मेरी फसल / शहद' : 'My Harvests'}</span>
          </li>

          {/* Highlighted Create Harvest tab */}
          <li 
            className={`sidebar-item sidebar-item-highlight ${activeSubTab === 'create-harvest' ? 'active' : ''}`}
            onClick={() => { resetHarvestForm(); setActiveSubTab('create-harvest'); }}
          >
            <PlusCircle size={20} />
            <span style={{ fontWeight: 800 }}>{primaryLang === 'hi' ? '➕ नया शहद जोड़ें' : '➕ Create New Harvest'}</span>
          </li>

          <li className="sidebar-label">{primaryLang === 'hi' ? 'पेटी प्रबंधन' : 'Apiary Management'}</li>

          <li 
            className={`sidebar-item ${activeSubTab === 'apiaries' ? 'active' : ''}`}
            onClick={() => setActiveSubTab('apiaries')}
          >
            <Compass size={20} />
            <span>{primaryLang === 'hi' ? 'स्थान और पेटियां' : 'Apiary Locations'}</span>
          </li>

          <li 
            className={`sidebar-item ${activeSubTab === 'health' ? 'active' : ''}`}
            onClick={() => setActiveSubTab('health')}
          >
            <Activity size={20} />
            <span>{primaryLang === 'hi' ? 'स्वास्थ्य रिकॉर्ड' : 'Health Logs'}</span>
          </li>

          <li 
            className={`sidebar-item ${activeSubTab === 'reminders' ? 'active' : ''}`}
            onClick={() => setActiveSubTab('reminders')}
          >
            <Bell size={20} />
            <span>{primaryLang === 'hi' ? 'याद दिलाएं / कार्य' : 'Reminders & Alerts'}</span>
          </li>

          <li 
            className={`sidebar-item ${activeSubTab === 'history' ? 'active' : ''}`}
            onClick={() => setActiveSubTab('history')}
          >
            <History size={20} />
            <span>{primaryLang === 'hi' ? 'ऑडिट इतिहास' : 'Audit History'}</span>
          </li>
        </ul>

        <div className="sidebar-footer">
          <div className="sidebar-profile" style={{ marginBottom: '1rem' }}>
            <div className="sidebar-avatar" style={{ fontSize: '1.5rem', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
              🧑‍🌾
            </div>
            <div>
              <div style={{ fontWeight: 700, fontSize: '0.95rem' }}>{user.registeredName}</div>
              <div style={{ fontSize: '0.75rem', color: '#FEF3C7' }}>ID: {user.beekeeperId}</div>
            </div>
          </div>
          <div 
            className="sidebar-item" 
            onClick={() => setView('role-selection')}
            style={{ color: '#FCA5A5', padding: '0.5rem', cursor: 'pointer' }}
          >
            <LogOut size={16} />
            <span>{primaryLang === 'hi' ? 'लॉगआउट / बाहर जाएं' : 'Exit Dashboard'}</span>
          </div>
        </div>
      </aside>

      {/* Main Content Area */}
      <main className="dashboard-main pb-mobile-nav">
        {/* Top Header */}
        <header className="dashboard-header">
          <div className="dashboard-title-area">
            <div style={{ display: 'flex', alignItems: 'center', gap: '0.6rem' }}>
              <h1>{primaryLang === 'hi' ? 'किसान मधुमक्खी पोर्टल' : 'Kisan Apiary Portal'}</h1>
              <SpeakerButton 
                text={primaryLang === 'hi' 
                  ? `नमस्ते ${user.registeredName}। आपके पास कुल ${totalHives} पेटियां और ${apiaries.length} स्थान सक्रिय हैं। नया शहद जोड़ने के लिए बड़े पीले बटन को दबाएं।`
                  : `Welcome ${user.registeredName}. You have ${totalHives} hives active across ${apiaries.length} locations.`}
                lang={primaryLang}
                size={20}
              />
            </div>
            <p style={{ color: 'var(--color-text-muted)', fontSize: '0.95rem' }}>
              {primaryLang === 'hi' ? 'शहद निकालाई, पेटी प्रवास और स्वास्थ्य रिकॉर्ड' : 'Honey harvest provenance & smart apiary logging'}
            </p>
          </div>

          <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem', flexWrap: 'wrap' }}>
            <span className="badge-active" style={{ display: 'inline-flex', alignItems: 'center', gap: '0.35rem', backgroundColor: '#DCFCE7', color: '#15803D', fontWeight: 700, padding: '0.5rem 0.9rem' }}>
              <ShieldCheck size={16} /> 
              <span>मधुक्रांति: {user.beekeeperId}</span>
            </span>
          </div>
        </header>

        {/* Offline / Online Sync Status Banner */}
        {isOffline ? (
          <div className="offline-sync-banner">
            <div style={{ display: 'flex', alignItems: 'center', gap: '0.6rem' }}>
              <WifiOff size={20} />
              <div>
                <strong>{primaryLang === 'hi' ? '🟡 ऑफलाइन मोड सक्रिय (फोन में सुरक्षित)' : '🟡 Offline Mode Active (Saved on Device)'}</strong>
                <div style={{ fontSize: '0.8rem', opacity: 0.9 }}>
                  {primaryLang === 'hi' ? 'आप बिना इंटरनेट के भी नया शहद दर्ज कर सकते हैं। 2G/4G नेटवर्क आने पर अपने आप क्लाउड पर सिंक हो जाएगा।' : 'You can log harvests offline. Records will sync to HoneyChain ledger when network reconnects.'}
                </div>
              </div>
            </div>
            <span className="badge-offline-count">3 {primaryLang === 'hi' ? 'बदलाव सुरक्षित' : 'Pending Sync'}</span>
          </div>
        ) : (
          <div className="online-sync-banner">
            <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
              <Wifi size={16} />
              <span>{primaryLang === 'hi' ? '🟢 लाइव सिंक चालू • राष्ट्रीय मधुक्रांति सर्वर से जुड़ा हुआ है' : '🟢 Live Sync Active • Connected to HoneyChain Ledger'}</span>
            </div>
          </div>
        )}

        {/* SINGLE MOST PROMINENT ACTION: Huge 64px "Create New Harvest" Button (Always reachable) */}
        {activeSubTab !== 'create-harvest' && (
          <div className="mega-action-container">
            <button 
              className="btn btn-primary mega-action-btn"
              onClick={() => { resetHarvestForm(); setActiveSubTab('create-harvest'); }}
            >
              <div className="mega-action-icon">🍯</div>
              <div className="mega-action-text">
                <span className="mega-action-title">
                  {primaryLang === 'hi' ? '➕ नया शहद जोड़ें (निकालाई दर्ज करें)' : '➕ Create New Harvest Record'}
                </span>
                <span className="mega-action-sub">
                  {primaryLang === 'hi' ? 'पेटी से शहद निकाला है? 1 मिनट में QR कोड बनाएं' : 'Extracted fresh honey? Generate container QR code in 1 min'}
                </span>
              </div>
              <ArrowRight size={28} className="mega-action-arrow" />
            </button>
          </div>
        )}

        {/* Dashboard Body Content */}
        <div className="dashboard-body">
          
          {/* TAB 1: OVERVIEW */}
          {activeSubTab === 'overview' && (
            <div>
              {/* High-contrast summary cards, icon-first, big numbers */}
              <div className="stats-grid">
                {/* 1. Apiaries */}
                <div className="stats-card-rural" onClick={() => setActiveSubTab('apiaries')}>
                  <div className="stats-card-icon-box" style={{ backgroundColor: '#FEF3C7', color: '#D97706' }}>
                    📍
                  </div>
                  <div className="stats-info">
                    <h4>{primaryLang === 'hi' ? 'मधुमक्खी स्थान' : 'Apiary Sites'}</h4>
                    <p className="stats-number">{apiaries.length}</p>
                    <span className="stats-sub-note">{primaryLang === 'hi' ? '2 सक्रिय क्षेत्र (UP)' : '2 active zones'}</span>
                  </div>
                </div>

                {/* 2. Total Hives */}
                <div className="stats-card-rural" onClick={() => setActiveSubTab('apiaries')}>
                  <div className="stats-card-icon-box" style={{ backgroundColor: '#DCFCE7', color: '#15803D' }}>
                    🐝
                  </div>
                  <div className="stats-info">
                    <h4>{primaryLang === 'hi' ? 'कुल पेटियां' : 'Total Hives'}</h4>
                    <p className="stats-number">{totalHives}</p>
                    <span className="stats-sub-note">{primaryLang === 'hi' ? 'लकड़ी की पेटियां' : 'Colony boxes'}</span>
                  </div>
                </div>

                {/* 3. Harvests Completed */}
                <div className="stats-card-rural" onClick={() => setActiveSubTab('harvests')}>
                  <div className="stats-card-icon-box" style={{ backgroundColor: '#FEF3C7', color: '#D97706' }}>
                    🍯
                  </div>
                  <div className="stats-info">
                    <h4>{primaryLang === 'hi' ? 'कुल निकालाई' : 'Harvests Done'}</h4>
                    <p className="stats-number">{myHarvests.length}</p>
                    <span className="stats-sub-note">{primaryLang === 'hi' ? 'प्रमाणित बैच' : 'Verified batches'}</span>
                  </div>
                </div>

                {/* 4. Hive Health Status */}
                <div className="stats-card-rural" onClick={() => setActiveSubTab('health')}>
                  <div className="stats-card-icon-box" style={{ backgroundColor: '#ECFDF5', color: '#059669' }}>
                    💚
                  </div>
                  <div className="stats-info">
                    <h4>{primaryLang === 'hi' ? 'स्वास्थ्य स्थिति' : 'Hive Health'}</h4>
                    <p className="stats-status-text" style={{ color: 'var(--color-secondary-dark)' }}>
                      {apiaries.some(a => a.status === 'Critical') ? '🔴 खतरा / Critical' : 
                       apiaries.some(a => a.status === 'Needs Attention') ? '🟡 ध्यान दें' : '🟢 स्वस्थ (Good)'}
                    </p>
                    <span className="stats-sub-note">{primaryLang === 'hi' ? 'नियमित जाँच पूर्ण' : 'Inspected recently'}</span>
                  </div>
                </div>
              </div>

              {/* Recent Harvests Table / Card List */}
              <div className="table-card" style={{ marginTop: '2rem' }}>
                <div className="table-card-header">
                  <div style={{ display: 'flex', alignItems: 'center', gap: '0.6rem' }}>
                    <h3 style={{ fontSize: '1.25rem', fontWeight: 800 }}>
                      {primaryLang === 'hi' ? 'हाल की शहद निकालाई (Recent Harvests)' : 'Recent Honey Harvests'}
                    </h3>
                    <SpeakerButton 
                      text={primaryLang === 'hi' 
                        ? "हाल की शहद निकालाई सूची। किसी भी बैच का QR कोड देखने के लिए QR कोड बटन दबाएं।"
                        : "Recent honey harvests list. Click QR code button to view container label."}
                      lang={primaryLang}
                      size={18}
                    />
                  </div>

                  <button className="btn btn-primary btn-sm" onClick={() => { resetHarvestForm(); setActiveSubTab('create-harvest'); }}>
                    <PlusCircle size={16} /> {primaryLang === 'hi' ? 'नया शहद जोड़ें' : 'Create Harvest'}
                  </button>
                </div>

                <div className="table-responsive">
                  <table className="custom-table">
                    <thead>
                      <tr>
                        <th>{primaryLang === 'hi' ? 'बैच / आईडी' : 'Harvest ID'}</th>
                        <th>{primaryLang === 'hi' ? 'तारीख' : 'Date'}</th>
                        <th>{primaryLang === 'hi' ? 'फूल का प्रकार' : 'Flower Source'}</th>
                        <th>{primaryLang === 'hi' ? 'स्थान' : 'Location'}</th>
                        <th>{primaryLang === 'hi' ? 'लैब जाँच' : 'Lab Status'}</th>
                        <th>{primaryLang === 'hi' ? 'ब्लॉकचेन' : 'Blockchain'}</th>
                        <th>{primaryLang === 'hi' ? 'कार्य' : 'Action'}</th>
                      </tr>
                    </thead>
                    <tbody>
                      {myHarvests.map((h) => (
                        <tr key={h.harvestId}>
                          <td>
                            <strong style={{ fontFamily: 'monospace', color: 'var(--color-primary-dark)', fontSize: '0.95rem' }}>
                              {h.harvestId}
                            </strong>
                          </td>
                          <td style={{ fontWeight: 600 }}>{h.harvestDate}</td>
                          <td>
                            {h.flowerSources.map(f => (
                              <span key={f} className="badge-flower">
                                🌼 {f}
                              </span>
                            ))}
                          </td>
                          <td>{h.locationName}</td>
                          <td>
                            <span className="badge-active" style={{ backgroundColor: '#D1FAE5', color: '#065F46', fontWeight: 700 }}>
                              🟢 ✓ {h.labStatus}
                            </span>
                          </td>
                          <td>
                            <span className="blockchain-status-tag">
                              <ShieldCheck size={14} /> {h.blockchainStatus}
                            </span>
                          </td>
                          <td>
                            <div style={{ display: 'flex', gap: '0.4rem' }}>
                              <button 
                                className="btn btn-secondary btn-sm"
                                onClick={() => {
                                  setActiveTraceId(h.harvestId);
                                  setView('consumer-trace');
                                }}
                                title="View Public QR Traceability"
                              >
                                <QrCode size={14} /> {primaryLang === 'hi' ? 'QR जाँच' : 'Trace'}
                              </button>
                            </div>
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
          )}

          {/* TAB 2: MY HARVESTS (Full List) */}
          {activeSubTab === 'harvests' && (
            <div>
              <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.5rem' }}>
                <div>
                  <h2 style={{ fontSize: '1.5rem', fontWeight: 800 }}>
                    {primaryLang === 'hi' ? 'मेरी सभी शहद निकालाई रिकॉर्ड' : 'All My Harvest Records'}
                  </h2>
                  <p style={{ color: 'var(--color-text-muted)', fontSize: '0.9rem' }}>
                    {primaryLang === 'hi' ? 'प्रत्येक रिकॉर्ड ब्लॉकचेन पर अपरिवर्तनीय रूप से सुरक्षित है।' : 'Each container record is permanently committed to HoneyChain ledger.'}
                  </p>
                </div>
                <button className="btn btn-primary" onClick={() => { resetHarvestForm(); setActiveSubTab('create-harvest'); }}>
                  <PlusCircle size={18} /> {primaryLang === 'hi' ? 'नया शहद जोड़ें' : 'New Harvest'}
                </button>
              </div>

              <div className="harvest-cards-grid">
                {myHarvests.map(h => (
                  <div key={h.harvestId} className="harvest-card-box">
                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '0.75rem' }}>
                      <div>
                        <span style={{ fontSize: '0.75rem', textTransform: 'uppercase', color: 'var(--color-text-light)', fontWeight: 700 }}>
                          {primaryLang === 'hi' ? 'शहद बैच कोड' : 'Harvest Batch ID'}
                        </span>
                        <h3 style={{ fontFamily: 'monospace', color: 'var(--color-primary-dark)', fontSize: '1.15rem' }}>
                          {h.harvestId}
                        </h3>
                      </div>
                      <span className="badge-active" style={{ backgroundColor: '#DCFCE7', color: '#15803D', fontWeight: 800 }}>
                        🟢 ✓ Verified
                      </span>
                    </div>

                    <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '0.75rem', fontSize: '0.88rem', margin: '0.75rem 0' }}>
                      <div>
                        <span style={{ color: 'var(--color-text-light)', fontSize: '0.78rem' }}>{primaryLang === 'hi' ? 'निकालाई तिथि' : 'Harvest Date'}</span>
                        <div style={{ fontWeight: 700 }}>{h.harvestDate}</div>
                      </div>
                      <div>
                        <span style={{ color: 'var(--color-text-light)', fontSize: '0.78rem' }}>{primaryLang === 'hi' ? 'मात्रा (अनुमानित)' : 'Quantity'}</span>
                        <div style={{ fontWeight: 700 }}>{h.quantityKg || 150} kg</div>
                      </div>
                      <div>
                        <span style={{ color: 'var(--color-text-light)', fontSize: '0.78rem' }}>{primaryLang === 'hi' ? 'फूल का प्रकार' : 'Flora'}</span>
                        <div>{h.flowerSources.join(', ')}</div>
                      </div>
                      <div>
                        <span style={{ color: 'var(--color-text-light)', fontSize: '0.78rem' }}>{primaryLang === 'hi' ? 'नमी (Moisture)' : 'Moisture'}</span>
                        <div style={{ fontWeight: 700, color: 'var(--color-secondary-dark)' }}>{h.moisture || '17.4% (Pass)'}</div>
                      </div>
                    </div>

                    <div style={{ borderTop: '1px dashed var(--color-border)', paddingTop: '0.75rem', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                      <span style={{ fontSize: '0.75rem', color: 'var(--color-text-light)' }}>
                        📍 {h.locationName}
                      </span>
                      <button 
                        className="btn btn-outline-green btn-sm"
                        onClick={() => {
                          setActiveTraceId(h.harvestId);
                          setView('consumer-trace');
                        }}
                      >
                        <QrCode size={14} /> {primaryLang === 'hi' ? 'QR कोड देखें' : 'View QR'}
                      </button>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          )}

          {/* TAB 3: CREATE HARVEST GUIDED WIZARD (One clear question at a time) */}
          {activeSubTab === 'create-harvest' && (
            <div className="wizard-card-container">
              {/* Wizard Progress Bar */}
              <div className="wizard-header">
                <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '0.5rem' }}>
                  <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                    <span className="wizard-step-badge">
                      {primaryLang === 'hi' ? `चरण ${wizardStep} of 6` : `Step ${wizardStep} of 6`}
                    </span>
                    <h2 style={{ fontSize: '1.4rem', fontWeight: 800, margin: 0 }}>
                      {wizardStep === 1 && (primaryLang === 'hi' ? 'किसान पहचान पुष्टि' : 'Beekeeper Confirmation')}
                      {wizardStep === 2 && (primaryLang === 'hi' ? 'शहद निकालने का स्थान (GPS)' : 'Apiary Location & GPS')}
                      {wizardStep === 3 && (primaryLang === 'hi' ? 'शहद निकालने की तारीख' : 'Harvest Date')}
                      {wizardStep === 4 && (primaryLang === 'hi' ? 'फूल का प्रकार चुनें (फ्लोरा)' : 'Select Floral Source')}
                      {wizardStep === 5 && (primaryLang === 'hi' ? 'लैब रिपोर्ट व फोटो' : 'Lab Test Report & Photo')}
                      {wizardStep === 6 && (primaryLang === 'hi' ? 'ब्लॉकचेन सत्यापन प्रगति' : 'Blockchain Verification')}
                    </h2>
                  </div>

                  <SpeakerButton 
                    text={
                      wizardStep === 1 ? "चरण एक: किसान पहचान। आपका नाम रवि कुमार और मधुक्रांति आईडी पहले से भरी हुई है। आगे बढ़ें।" :
                      wizardStep === 2 ? "चरण दो: शहद निकालने का स्थान। जीपीएस ऑटो-डिटेक्ट बटन दबाएं या अपनी पेटी का स्थान चुनें।" :
                      wizardStep === 3 ? "चरण तीन: शहद निकालने की तारीख। आज की तारीख पहले से चुनी हुई है।" :
                      wizardStep === 4 ? "चरण चार: फूल का प्रकार। जिस फूल से शहद निकला है उस पर टैप करें, जैसे सरसों या यूकेलिप्टस।" :
                      wizardStep === 5 ? "चरण पांच: लैब रिपोर्ट की फोटो लें या पीडीएफ जोड़ें।" :
                      "चरण छह: स्मार्ट अनुबंध सत्यापन और QR कोड निर्माण।"
                    }
                    lang={primaryLang}
                    size={20}
                  />
                </div>

                {/* Step dots */}
                <div className="wizard-dots-row">
                  {[1, 2, 3, 4, 5, 6].map(s => (
                    <div 
                      key={s} 
                      className={`wizard-dot ${wizardStep === s ? 'active' : wizardStep > s ? 'completed' : ''}`}
                    >
                      {wizardStep > s ? '✓' : s}
                    </div>
                  ))}
                </div>
              </div>

              {/* WIZARD STEP 1: Beekeeper Confirmation */}
              {wizardStep === 1 && (
                <div className="wizard-body">
                  <div className="wizard-question-box">
                    <p style={{ fontSize: '1.1rem', color: 'var(--color-text-muted)', marginBottom: '1.5rem' }}>
                      {primaryLang === 'hi' 
                        ? 'कृपया पुष्टि करें कि यह शहद आपके पंजीकृत मधुक्रांति खाते के अंतर्गत दर्ज हो रहा है:'
                        : 'Please confirm that this harvest extraction belongs to your verified registry identity:'}
                    </p>

                    <div className="verify-results" style={{ padding: '1.5rem', backgroundColor: '#FDFBF7', border: '2px solid var(--color-primary-light)', borderRadius: 'var(--radius-md)' }}>
                      <div className="verify-data-row">
                        <span className="verify-data-label">{primaryLang === 'hi' ? 'किसान का नाम:' : 'Beekeeper Name:'}</span>
                        <span className="verify-data-value" style={{ fontSize: '1.2rem', fontWeight: 800 }}>{user.registeredName}</span>
                      </div>
                      <div className="verify-data-row">
                        <span className="verify-data-label">{primaryLang === 'hi' ? 'मधुक्रांति आईडी:' : 'Madhukranti ID:'}</span>
                        <span className="verify-data-value">
                          <code style={{ fontSize: '1rem', color: 'var(--color-primary-dark)' }}>{user.beekeeperId}</code>
                        </span>
                      </div>
                      <div className="verify-data-row">
                        <span className="verify-data-label">{primaryLang === 'hi' ? 'राज्य / जिला:' : 'State:'}</span>
                        <span className="verify-data-value">{user.state} ({user.district})</span>
                      </div>
                      <div className="verify-data-row">
                        <span className="verify-data-label">{primaryLang === 'hi' ? 'स्थिति:' : 'Status:'}</span>
                        <span className="verify-data-value">
                          <span className="badge-active" style={{ backgroundColor: '#DCFCE7', color: '#15803D', fontWeight: 800 }}>
                            🟢 ACTIVE ✅
                          </span>
                        </span>
                      </div>
                    </div>
                  </div>

                  <div className="wizard-actions">
                    <button className="btn btn-secondary" onClick={() => setActiveSubTab('overview')}>
                      {primaryLang === 'hi' ? 'रद्द करें' : 'Cancel'}
                    </button>
                    <button className="btn btn-primary btn-wizard-next" onClick={() => setWizardStep(2)}>
                      <span>{primaryLang === 'hi' ? 'सही है, आगे बढ़ें (Next)' : 'Confirm & Next'}</span>
                      <ArrowRight size={20} />
                    </button>
                  </div>
                </div>
              )}

              {/* WIZARD STEP 2: Extraction Location (GPS Auto-detect + Fallback) */}
              {wizardStep === 2 && (
                <div className="wizard-body">
                  <div className="wizard-question-box">
                    <label className="form-label" style={{ fontSize: '1.15rem', fontWeight: 700, marginBottom: '0.75rem', display: 'block' }}>
                      {primaryLang === 'hi' ? 'शहद कहाँ से निकाला गया?' : 'Where was this honey extracted?'}
                    </label>

                    {/* Primary Big GPS Auto-Detect Button */}
                    <button 
                      type="button"
                      className="btn btn-outline-green btn-gps-large"
                      onClick={handleAutoDetectGps}
                      disabled={gpsDetecting}
                      style={{ width: '100%', minHeight: '68px', marginBottom: '1.5rem', display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '0.75rem', fontSize: '1.1rem', fontWeight: 800 }}
                    >
                      <MapPin size={28} className={gpsDetecting ? 'pulse-icon' : ''} />
                      <div style={{ textAlign: 'left' }}>
                        <div>{gpsDetecting ? (primaryLang === 'hi' ? 'जीपीएस खोजा जा रहा है...' : 'Detecting GPS...') : (primaryLang === 'hi' ? '📍 फोन जीपीएस से स्थान लें (Auto-Detect GPS)' : '📍 Auto-Detect GPS Location')}</div>
                        <div style={{ fontSize: '0.8rem', fontWeight: 500, opacity: 0.85 }}>{gpsDetected}</div>
                      </div>
                    </button>

                    <div style={{ borderTop: '1px dashed var(--color-border)', paddingTop: '1.25rem', marginBottom: '1.25rem' }}>
                      <label className="form-label" htmlFor="apiary-select-wizard">
                        {primaryLang === 'hi' ? 'या अपनी पंजीकृत पेटी स्थान चुनें:' : 'Or choose from registered apiaries:'}
                      </label>
                      <select 
                        id="apiary-select-wizard"
                        className="form-input" 
                        value={selectedApiaryId}
                        onChange={(e) => setSelectedApiaryId(e.target.value)}
                        style={{ height: '56px', fontSize: '1.05rem' }}
                      >
                        {apiaries.map(a => (
                          <option key={a.locationId} value={a.locationId}>
                            {a.name} ({a.hiveCount} Hives - {a.villageName || a.gps})
                          </option>
                        ))}
                      </select>
                    </div>

                    <div className="form-group">
                      <label className="form-label" htmlFor="fallback-location-text">
                        {primaryLang === 'hi' ? 'गाँव / क्षेत्र का नाम (यदि GPS कमजोर हो):' : 'Village / Area Fallback (if weak GPS):'}
                      </label>
                      <input 
                        id="fallback-location-text"
                        type="text" 
                        className="form-input" 
                        placeholder={primaryLang === 'hi' ? 'उदा. ग्राम लोनी, रामपुर, उत्तर प्रदेश' : 'e.g. Village Loni, Ghaziabad, UP'}
                        value={customLocationText}
                        onChange={(e) => setCustomLocationText(e.target.value)}
                      />
                    </div>
                  </div>

                  <div className="wizard-actions">
                    <button className="btn btn-secondary" onClick={() => setWizardStep(1)}>
                      <ArrowLeft size={18} /> {primaryLang === 'hi' ? 'पीछे' : 'Back'}
                    </button>
                    <button className="btn btn-primary btn-wizard-next" onClick={() => setWizardStep(3)}>
                      <span>{primaryLang === 'hi' ? 'आगे बढ़ें (Next)' : 'Next Step'}</span>
                      <ArrowRight size={20} />
                    </button>
                  </div>
                </div>
              )}

              {/* WIZARD STEP 3: Harvest Date */}
              {wizardStep === 3 && (
                <div className="wizard-body">
                  <div className="wizard-question-box">
                    <label className="form-label" style={{ fontSize: '1.15rem', fontWeight: 700, marginBottom: '0.75rem', display: 'block' }}>
                      {primaryLang === 'hi' ? 'शहद किस दिन निकाला गया?' : 'When was this honey extracted?'}
                    </label>

                    {/* 1-Tap Quick Date Pills */}
                    <div style={{ display: 'flex', gap: '0.75rem', marginBottom: '1.25rem' }}>
                      <button 
                        type="button"
                        className="btn btn-secondary"
                        onClick={() => setHarvestDate(new Date().toISOString().split('T')[0])}
                        style={{ minHeight: '52px', flex: 1, fontWeight: 700 }}
                      >
                        📅 {primaryLang === 'hi' ? 'आज (Today)' : 'Today'}
                      </button>
                      <button 
                        type="button"
                        className="btn btn-secondary"
                        onClick={() => {
                          const yest = new Date();
                          yest.setDate(yest.getDate() - 1);
                          setHarvestDate(yest.toISOString().split('T')[0]);
                        }}
                        style={{ minHeight: '52px', flex: 1, fontWeight: 700 }}
                      >
                        📅 {primaryLang === 'hi' ? 'कल (Yesterday)' : 'Yesterday'}
                      </button>
                    </div>

                    <div className="form-group">
                      <label className="form-label" htmlFor="harvest-date-picker">
                        {primaryLang === 'hi' ? 'या कैलेंडर से तारीख चुनें:' : 'Or choose date from calendar:'}
                      </label>
                      <input 
                        id="harvest-date-picker"
                        type="date" 
                        className="form-input" 
                        value={harvestDate}
                        onChange={(e) => setHarvestDate(e.target.value)}
                        style={{ height: '56px', fontSize: '1.15rem', fontWeight: 600 }}
                        required
                      />
                    </div>
                  </div>

                  <div className="wizard-actions">
                    <button className="btn btn-secondary" onClick={() => setWizardStep(2)}>
                      <ArrowLeft size={18} /> {primaryLang === 'hi' ? 'पीछे' : 'Back'}
                    </button>
                    <button className="btn btn-primary btn-wizard-next" onClick={() => setWizardStep(4)}>
                      <span>{primaryLang === 'hi' ? 'आगे बढ़ें (Next)' : 'Next Step'}</span>
                      <ArrowRight size={20} />
                    </button>
                  </div>
                </div>
              )}

              {/* WIZARD STEP 4: Primary Floral Source (Large visual chips with icons) */}
              {wizardStep === 4 && (
                <div className="wizard-body">
                  <div className="wizard-question-box">
                    <label className="form-label" style={{ fontSize: '1.15rem', fontWeight: 700, marginBottom: '0.75rem', display: 'block' }}>
                      {primaryLang === 'hi' ? 'मधुमक्खियों ने किस फूल से रस लिया? (फूल का प्रकार)' : 'What is the primary floral source? (Tap to select)'}
                    </label>

                    <div className="floral-chips-grid">
                      {flowerOptions.map(flower => {
                        const isSelected = selectedFlowers.includes(flower.id);
                        return (
                          <div 
                            key={flower.id}
                            className={`floral-chip-large ${isSelected ? 'selected' : ''}`}
                            onClick={() => handleFlowerToggle(flower.id)}
                            tabIndex={0}
                            role="button"
                          >
                            <span className="floral-chip-emoji">{flower.icon}</span>
                            <div className="floral-chip-text">
                              <span className="floral-chip-title">
                                {primaryLang === 'hi' ? flower.nameHi : flower.nameEn}
                              </span>
                              <span className="floral-chip-sub">
                                {primaryLang === 'hi' ? flower.nameEn : flower.nameHi}
                              </span>
                            </div>
                            {isSelected && <span className="chip-check-icon">✓</span>}
                          </div>
                        );
                      })}
                    </div>
                  </div>

                  <div className="wizard-actions">
                    <button className="btn btn-secondary" onClick={() => setWizardStep(3)}>
                      <ArrowLeft size={18} /> {primaryLang === 'hi' ? 'पीछे' : 'Back'}
                    </button>
                    <button className="btn btn-primary btn-wizard-next" onClick={() => setWizardStep(5)}>
                      <span>{primaryLang === 'hi' ? 'आगे बढ़ें (Next)' : 'Next Step'}</span>
                      <ArrowRight size={20} />
                    </button>
                  </div>
                </div>
              )}

              {/* WIZARD STEP 5: Lab Report Reference & Camera Photo */}
              {wizardStep === 5 && (
                <div className="wizard-body">
                  <div className="wizard-question-box">
                    <label className="form-label" style={{ fontSize: '1.15rem', fontWeight: 700, marginBottom: '0.5rem', display: 'block' }}>
                      {primaryLang === 'hi' ? 'सरकारी लैब जाँच व रिपोर्ट फोटो' : 'Laboratory Purity Report & Photo'}
                    </label>
                    <p style={{ fontSize: '0.88rem', color: 'var(--color-text-muted)', marginBottom: '1.25rem' }}>
                      {primaryLang === 'hi'
                        ? 'यदि आपके पास सरकारी लैब की पर्ची है, तो उसकी फोटो खींचें (वैकल्पिक)।'
                        : 'Attach official purity test report or take a photo of the lab paper slip (optional).'}
                    </p>

                    <div className="form-group" style={{ marginBottom: '1.25rem' }}>
                      <label className="form-label" htmlFor="lab-name-select-wizard">
                        {primaryLang === 'hi' ? 'जाँच प्रयोगशाला (Testing Lab):' : 'Testing Laboratory:'}
                      </label>
                      <select 
                        id="lab-name-select-wizard"
                        className="form-input"
                        value={labName}
                        onChange={(e) => setLabName(e.target.value)}
                        style={{ height: '56px', fontSize: '1rem' }}
                      >
                        <option value="Demo Honey Testing Laboratory (NABL #104)">Demo Honey Testing Laboratory (NABL #104, UP)</option>
                        <option value="National Honey Analytics & Purity Center">National Honey Analytics & Purity Center (Pune)</option>
                        <option value="Apex Food Quality Lab">Apex Food Quality Lab (New Delhi)</option>
                      </select>
                    </div>

                    {/* Big Camera-Icon Button for Taking Paper Photo */}
                    <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem', marginTop: '1rem' }}>
                      <button 
                        type="button"
                        className={`btn ${labPhotoCaptured ? 'btn-green' : 'btn-outline-green'}`}
                        onClick={() => setLabPhotoCaptured(!labPhotoCaptured)}
                        style={{ minHeight: '64px', display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '0.6rem', fontSize: '1rem', fontWeight: 700 }}
                      >
                        <Camera size={24} />
                        <span>{labPhotoCaptured ? (primaryLang === 'hi' ? '📷 फोटो संलग्न है ✓' : '📷 Photo Attached ✓') : (primaryLang === 'hi' ? '📷 पर्चे की फोटो लें' : '📷 Take Report Photo')}</span>
                      </button>

                      <div 
                        className="file-upload-box-wizard" 
                        onClick={() => document.getElementById('lab-pdf-upload')?.click()}
                        style={{ minHeight: '64px', display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '0.6rem', border: '2px dashed var(--color-border)', borderRadius: 'var(--radius-md)', cursor: 'pointer', padding: '0.5rem 1rem', backgroundColor: '#FDFBF7' }}
                      >
                        <Upload size={20} style={{ color: 'var(--color-primary-dark)' }} />
                        <span style={{ fontSize: '0.88rem', fontWeight: 600 }}>
                          {labReportFile ? `${labReportFile.name} (PDF)` : (primaryLang === 'hi' ? 'PDF रिपोर्ट चुनें' : 'Upload PDF')}
                        </span>
                      </div>
                      <input 
                        id="lab-pdf-upload"
                        type="file" 
                        accept=".pdf,image/*" 
                        style={{ display: 'none' }}
                        onChange={(e) => { if(e.target.files?.[0]) setLabReportFile(e.target.files[0]); }}
                      />
                    </div>

                    {/* 2G Compression indicator badge */}
                    {(labPhotoCaptured || labReportFile) && (
                      <div style={{ marginTop: '0.9rem', padding: '0.6rem 0.9rem', backgroundColor: '#DCFCE7', borderRadius: 'var(--radius-sm)', fontSize: '0.8rem', color: '#15803D', display: 'flex', alignItems: 'center', gap: '0.4rem', fontWeight: 600 }}>
                        <CheckCircle2 size={16} />
                        <span>⚡ 2G नेटवर्क के लिए कंप्रेस किया गया (3.8MB → 120KB)</span>
                      </div>
                    )}
                  </div>

                  <div className="wizard-actions">
                    <button className="btn btn-secondary" onClick={() => setWizardStep(4)}>
                      <ArrowLeft size={18} /> {primaryLang === 'hi' ? 'पीछे' : 'Back'}
                    </button>
                    <button className="btn btn-green btn-wizard-next" onClick={startVerificationProcess}>
                      <span>{primaryLang === 'hi' ? 'सत्यापित करें व QR कोड बनाएं' : 'Verify & Generate QR'}</span>
                      <Sparkles size={20} />
                    </button>
                  </div>
                </div>
              )}

              {/* WIZARD STEP 6: Smart Verification Animation & Output Screen */}
              {wizardStep === 6 && (
                <div className="wizard-body">
                  {verificationStep < 5 ? (
                    <div style={{ padding: '2rem 1rem', textAlign: 'center' }}>
                      <h3 style={{ fontSize: '1.4rem', marginBottom: '1.5rem', fontWeight: 800 }}>
                        {primaryLang === 'hi' ? 'हनीचेन स्मार्ट सत्यापन प्रगति...' : 'Verifying Harvest & Committing to Ledger...'}
                      </h3>

                      <div style={{ display: 'flex', justifyContent: 'center', marginBottom: '2rem' }}>
                        <div className="flow-circle active pulse-icon" style={{ width: '4.5rem', height: '4.5rem', fontSize: '1.6rem' }}>
                          ⛓️
                        </div>
                      </div>

                      {/* Animated Checklist */}
                      <ul className="rural-progress-list">
                        <li className={`rural-progress-item ${verificationStep >= 1 ? 'done' : ''}`}>
                          <span className="rural-bullet">{verificationStep >= 1 ? '✓' : '1'}</span>
                          <span>{primaryLang === 'hi' ? 'किसान पहचान (Madhukranti Registry) प्रमाणित...' : 'Beekeeper ID Checked in Registry...'}</span>
                        </li>
                        <li className={`rural-progress-item ${verificationStep >= 2 ? 'done' : ''}`}>
                          <span className="rural-bullet">{verificationStep >= 2 ? '✓' : '2'}</span>
                          <span>{primaryLang === 'hi' ? 'गाँव GPS निर्देशांक व फ्लोरा सत्यापित...' : 'Apiary Location & Floral Integrity Verified...'}</span>
                        </li>
                        <li className={`rural-progress-item ${verificationStep >= 3 ? 'done' : ''}`}>
                          <span className="rural-bullet">{verificationStep >= 3 ? '✓' : '3'}</span>
                          <span>{primaryLang === 'hi' ? 'NABL लैब परीक्षण रिपोर्ट व नमी पैरामीटर जांचे गए...' : 'Lab Report & Moisture Parameters Validated...'}</span>
                        </li>
                        <li className={`rural-progress-item ${verificationStep >= 4 ? 'done' : ''}`}>
                          <span className="rural-bullet">{verificationStep >= 4 ? '✓' : '4'}</span>
                          <span>{primaryLang === 'hi' ? 'हनीचेन स्मार्ट कॉन्ट्रैक्ट SHA-256 ब्लॉक दर्ज हो रहा है...' : 'Generating Cryptographic Block Hash...'}</span>
                        </li>
                      </ul>
                    </div>
                  ) : (
                    /* Final Output Screen: Big Printable QR Code */
                    <div className="success-output-screen">
                      <div className="success-icon-badge">
                        <Check size={36} />
                      </div>

                      <h2 style={{ fontSize: '1.8rem', fontWeight: 900, color: 'var(--color-secondary-dark)', marginBottom: '0.25rem' }}>
                        {primaryLang === 'hi' ? 'शहद निकालाई सफलतापूर्वक दर्ज!' : 'Harvest Registered Successfully!'}
                      </h2>
                      <p style={{ color: 'var(--color-text-muted)', fontSize: '0.95rem', marginBottom: '1.75rem' }}>
                        {primaryLang === 'hi' ? 'ब्लॉकचेन रिकॉर्ड सुरक्षित हो चुका है। अपने डिब्बे के लिए QR कोड डाउनलोड करें:' : 'Record permanently committed to blockchain. Print container QR label below:'}
                      </p>

                      {/* Big Printable QR Code Box Dominating Screen */}
                      <div className="printable-qr-card">
                        <div className="qr-card-top-tag">
                          🍯 HoneyChain Container Label • भारतीय शहद प्रमाण
                        </div>
                        
                        <div className="qr-large-graphic">
                          <QrCode size={180} color="#1F2937" />
                        </div>

                        <div className="qr-details-block">
                          <div style={{ fontSize: '0.8rem', color: 'var(--color-text-light)', textTransform: 'uppercase', fontWeight: 700 }}>
                            {primaryLang === 'hi' ? 'शहद बैच नंबर (Harvest ID)' : 'Harvest Batch ID'}
                          </div>
                          <div style={{ fontSize: '1.25rem', fontFamily: 'monospace', fontWeight: 900, color: 'var(--color-primary-dark)' }}>
                            {createdHarvestId}
                          </div>
                          <div style={{ fontSize: '0.9rem', fontWeight: 700, marginTop: '0.35rem' }}>
                            {user.registeredName} • {selectedFlowers.join('/')} Honey
                          </div>
                          <div style={{ fontSize: '0.78rem', color: 'var(--color-text-muted)' }}>
                            {harvestDate} • {user.state}
                          </div>
                        </div>

                        <button 
                          className="btn btn-green btn-print-main"
                          onClick={() => alert(primaryLang === 'hi' ? "प्रिंट डायलॉग खुला: यह QR कोड शहद के डिब्बे पर चिपकाया जा सकता है।" : "Printing QR container label...")}
                        >
                          <Printer size={20} />
                          <span>{primaryLang === 'hi' ? 'डिब्बों के लिए QR कोड डाउनलोड / प्रिंट करें' : 'Print / Save QR Code for Containers'}</span>
                        </button>
                      </div>

                      {/* Secondary Action Options */}
                      <div style={{ display: 'flex', gap: '1rem', justifyContent: 'center', marginTop: '2rem', flexWrap: 'wrap' }}>
                        <button 
                          className="btn btn-outline-green" 
                          onClick={() => {
                            setActiveTraceId(createdHarvestId);
                            setView('consumer-trace');
                          }}
                          style={{ minHeight: '52px', fontSize: '1rem', fontWeight: 700 }}
                        >
                          🔍 {primaryLang === 'hi' ? 'पब्लिक सत्यापन पेज देखें' : 'View Public Trace Page'}
                        </button>

                        <button 
                          className="btn btn-primary" 
                          onClick={() => {
                            resetHarvestForm();
                            setActiveSubTab('overview');
                          }}
                          style={{ minHeight: '52px', fontSize: '1rem', fontWeight: 800 }}
                        >
                          🏠 {primaryLang === 'hi' ? 'हो गया, डैशबोर्ड पर जाएं' : 'Done, Back to Dashboard'}
                        </button>
                      </div>
                    </div>
                  )}
                </div>
              )}
            </div>
          )}

          {/* TAB 4: APIARY LOCATIONS & COLONY MIGRATION */}
          {activeSubTab === 'apiaries' && (
            <div>
              <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.5rem', flexWrap: 'wrap', gap: '1rem' }}>
                <div>
                  <h2 style={{ fontSize: '1.5rem', fontWeight: 800 }}>
                    {primaryLang === 'hi' ? 'मेरे मधुमक्खी स्थान व पेटियां' : 'My Apiary Sites & Colony Boxes'}
                  </h2>
                  <p style={{ color: 'var(--color-text-muted)', fontSize: '0.9rem' }}>
                    {primaryLang === 'hi' ? 'फूलों के मौसम अनुसार पेटियों का प्रवास और विभाजन प्रबंधित करें।' : 'Manage seasonal colony migration to new flora and split hives.'}
                  </p>
                </div>

                <button 
                  className="btn btn-primary"
                  onClick={() => {
                    const name = prompt("Enter Apiary Site Name (स्थान का नाम):", `Apiary ${apiaries.length + 1} - New Flora`);
                    const count = prompt("Initial Hive Count (पेटियों की संख्या):", "8");
                    const gps = prompt("GPS Coordinate (जीपीएस निर्देशांक):", "28.8500, 79.1000");
                    if (name && count) {
                      const newAp = {
                        locationId: `LOC-00${apiaries.length + 1}`,
                        name: name,
                        gps: gps || "28.8500, 79.1000",
                        villageName: "Village Site",
                        hiveCount: parseInt(count) || 6,
                        flora: "Multifloral Blooms",
                        status: "Healthy",
                        lastInspection: new Date().toISOString().split('T')[0],
                        notes: "Newly established apiary site"
                      };
                      setApiaries([...apiaries, newAp]);
                    }
                  }}
                >
                  <PlusCircle size={18} /> {primaryLang === 'hi' ? 'नया स्थान जोड़ें' : 'Add New Location'}
                </button>
              </div>

              <div className="apiary-grid">
                {apiaries.map(ap => (
                  <div key={ap.locationId} className="apiary-card-rural">
                    <div className="apiary-card-top">
                      <div>
                        <span className="apiary-loc-id">{ap.locationId}</span>
                        <h3 style={{ fontSize: '1.25rem', fontWeight: 800, margin: '0.25rem 0' }}>{ap.name}</h3>
                        <div style={{ fontSize: '0.85rem', color: 'var(--color-text-muted)' }}>📍 {ap.villageName || ap.gps}</div>
                      </div>
                      <span className={`badge-active ${
                        ap.status === 'Healthy' ? 'status-healthy' : 'badge-expired'
                      }`} style={{
                        backgroundColor: ap.status === 'Healthy' ? '#DCFCE7' : '#FEF3C7',
                        color: ap.status === 'Healthy' ? '#15803D' : '#D97706',
                        fontWeight: 800
                      }}>
                        {ap.status === 'Healthy' ? '🟢 स्वस्थ (Good)' : '🟡 ध्यान दें'}
                      </span>
                    </div>

                    <div className="apiary-stats-row">
                      <div className="apiary-stat-item">
                        <span className="apiary-stat-label">{primaryLang === 'hi' ? 'कुल पेटियां' : 'Colony Boxes'}</span>
                        <strong className="apiary-stat-val">🐝 {ap.hiveCount} Units</strong>
                      </div>
                      <div className="apiary-stat-item">
                        <span className="apiary-stat-label">{primaryLang === 'hi' ? 'वर्तमान फ्लोरा' : 'Flora'}</span>
                        <strong className="apiary-stat-val" style={{ fontSize: '0.85rem' }}>{ap.flora || 'Mustard'}</strong>
                      </div>
                      <div className="apiary-stat-item">
                        <span className="apiary-stat-label">{primaryLang === 'hi' ? 'अंतिम जाँच' : 'Last Check'}</span>
                        <strong className="apiary-stat-val" style={{ fontSize: '0.85rem' }}>{ap.lastInspection}</strong>
                      </div>
                    </div>

                    {/* Colony Migration & Split Actions */}
                    <div className="apiary-actions-grid">
                      <button 
                        className="btn btn-outline-green btn-sm"
                        onClick={() => handleOpenMoveModal(ap)}
                        style={{ fontWeight: 700, padding: '0.65rem' }}
                      >
                        🚚 {primaryLang === 'hi' ? 'नया स्थान बदलें / प्रवास' : 'Move to New Flora'}
                      </button>

                      <button 
                        className="btn btn-secondary btn-sm"
                        onClick={() => {
                          setLogApiaryId(ap.locationId);
                          setActiveSubTab('health');
                        }}
                        style={{ fontWeight: 700, padding: '0.65rem' }}
                      >
                        🩺 {primaryLang === 'hi' ? 'स्वास्थ्य दर्ज करें' : 'Log Health'}
                      </button>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          )}

          {/* TAB 5: HEALTH LOGS & INSPECTION (With Voice Note Mock) */}
          {activeSubTab === 'health' && (
            <div className="health-section-layout">
              {/* Add Health Log Form */}
              <div className="form-card" style={{ margin: 0 }}>
                <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '1rem' }}>
                  <h3 style={{ fontSize: '1.3rem', fontWeight: 800, margin: 0 }}>
                    {primaryLang === 'hi' ? 'पेटी स्वास्थ्य निरीक्षण दर्ज करें' : 'Log Hive Health Inspection'}
                  </h3>
                  <SpeakerButton 
                    text={primaryLang === 'hi' 
                      ? "पेटी स्वास्थ्य निरीक्षण। अपनी पेटी की स्थिति चुनें: हरा यानी स्वस्थ, पीला यानी ध्यान दें, लाल यानी खतरा।"
                      : "Hive health inspection. Select health status chip: Green for healthy, Amber for attention, Red for critical."}
                    lang={primaryLang}
                    size={18}
                  />
                </div>

                <form onSubmit={handleAddHealthLog}>
                  <div className="form-group">
                    <label className="form-label" htmlFor="health-apiary-select-tab">
                      {primaryLang === 'hi' ? 'मधुमक्खी स्थान (Apiary Site):' : 'Target Apiary Site:'}
                    </label>
                    <select 
                      id="health-apiary-select-tab"
                      className="form-input"
                      value={logApiaryId}
                      onChange={(e) => setLogApiaryId(e.target.value)}
                      style={{ height: '52px' }}
                    >
                      {apiaries.map(a => (
                        <option key={a.locationId} value={a.locationId}>{a.name} ({a.hiveCount} Hives)</option>
                      ))}
                    </select>
                  </div>

                  {/* 3 Big Status Chips: Healthy, Needs Attention, Critical */}
                  <div className="form-group">
                    <label className="form-label" style={{ fontWeight: 700 }}>
                      {primaryLang === 'hi' ? 'स्वास्थ्य स्थिति (Status):' : 'Hive Health Status:'}
                    </label>
                    <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: '0.75rem' }}>
                      <div 
                        className={`status-chip-box ${logStatus === 'Healthy' ? 'selected-healthy' : ''}`}
                        onClick={() => setLogStatus('Healthy')}
                        tabIndex={0}
                        role="button"
                      >
                        <span style={{ fontSize: '1.5rem' }}>🟢</span>
                        <strong>{primaryLang === 'hi' ? 'सब ठीक है' : 'Healthy'}</strong>
                        <span style={{ fontSize: '0.75rem', opacity: 0.85 }}>Good Condition</span>
                      </div>

                      <div 
                        className={`status-chip-box ${logStatus === 'Needs Attention' ? 'selected-warning' : ''}`}
                        onClick={() => setLogStatus('Needs Attention')}
                        tabIndex={0}
                        role="button"
                      >
                        <span style={{ fontSize: '1.5rem' }}>🟡</span>
                        <strong>{primaryLang === 'hi' ? 'ध्यान दें' : 'Attention'}</strong>
                        <span style={{ fontSize: '0.75rem', opacity: 0.85 }}>Mites / Pests</span>
                      </div>

                      <div 
                        className={`status-chip-box ${logStatus === 'Critical' ? 'selected-critical' : ''}`}
                        onClick={() => setLogStatus('Critical')}
                        tabIndex={0}
                        role="button"
                      >
                        <span style={{ fontSize: '1.5rem' }}>🔴</span>
                        <strong>{primaryLang === 'hi' ? 'खतरा' : 'Critical'}</strong>
                        <span style={{ fontSize: '0.75rem', opacity: 0.85 }}>Severe Issue</span>
                      </div>
                    </div>
                  </div>

                  <div className="form-group">
                    <label className="form-label" htmlFor="affected-boxes-input">
                      {primaryLang === 'hi' ? 'प्रभावित पेटियों की संख्या (यदि कोई हो):' : 'Affected Hive Count (if any):'}
                    </label>
                    <input 
                      id="affected-boxes-input"
                      type="number" 
                      className="form-input" 
                      min="0"
                      value={logColonies}
                      onChange={(e) => setLogColonies(e.target.value)}
                      style={{ height: '52px', fontSize: '1.1rem' }}
                    />
                  </div>

                  {/* Notes Entry with Mock Voice Note Microphone */}
                  <div className="form-group">
                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '0.4rem' }}>
                      <label className="form-label" htmlFor="health-notes-input" style={{ margin: 0 }}>
                        {primaryLang === 'hi' ? 'निरीक्षण विवरण / नोट:' : 'Inspection Notes:'}
                      </label>
                      
                      {/* Voice Note Button for low-literacy farmers */}
                      <button 
                        type="button"
                        className={`btn-voice-note ${isRecordingVoice ? 'recording' : ''}`}
                        onClick={handleToggleVoiceRecord}
                        title="Record Voice Note (बोलकर नोट दर्ज करें)"
                      >
                        <Mic size={16} />
                        <span>{isRecordingVoice ? (primaryLang === 'hi' ? 'बोलिए... (Recording)' : 'Listening...') : (primaryLang === 'hi' ? '🎤 बोलकर लिखें (Voice Note)' : '🎤 Voice Note')}</span>
                      </button>
                    </div>

                    <textarea 
                      id="health-notes-input"
                      className="form-input" 
                      rows="3" 
                      placeholder={primaryLang === 'hi' ? 'उदा. पेटी 2 में रानी मधुमक्खी सक्रिय है, शहद का छत्ता भर रहा है...' : 'e.g. Brood pattern uniform, honey frames filling well...'}
                      value={logNotes}
                      onChange={(e) => setLogNotes(e.target.value)}
                    ></textarea>

                    {voiceRecorded && (
                      <div style={{ marginTop: '0.5rem', fontSize: '0.8rem', color: 'var(--color-secondary-dark)', display: 'flex', alignItems: 'center', gap: '0.35rem' }}>
                        <CheckCircle2 size={14} />
                        <span>{primaryLang === 'hi' ? 'आवाज़ पहचान कर नोट में जोड़ा गया' : 'Voice note transcribed successfully'}</span>
                      </div>
                    )}
                  </div>

                  <button type="submit" className="btn btn-primary" style={{ width: '100%', minHeight: '56px', fontSize: '1.1rem', fontWeight: 800 }}>
                    {primaryLang === 'hi' ? 'स्वास्थ्य रिकॉर्ड सुरक्षित करें' : 'Save Health Log'}
                  </button>
                </form>
              </div>

              {/* Visual History Timeline */}
              <div className="table-card" style={{ padding: '1.5rem', margin: 0 }}>
                <h3 style={{ fontSize: '1.25rem', fontWeight: 800, marginBottom: '1rem' }}>
                  {primaryLang === 'hi' ? 'स्वास्थ्य निरीक्षण इतिहास' : 'Inspection Timeline'}
                </h3>
                
                <div className="log-timeline">
                  {healthLogs.map(log => (
                    <div key={log.id} className={`log-item ${
                      log.status === 'Healthy' ? 'status-healthy' : 
                      log.status === 'Needs Attention' ? 'status-needs-attention' : 'status-critical'
                    }`}>
                      <div className="log-meta">
                        <strong style={{ color: 'var(--color-text-main)', fontSize: '0.95rem' }}>
                          {log.apiaryName}
                        </strong>
                        <span style={{ fontSize: '0.82rem', color: 'var(--color-text-light)' }}>{log.date}</span>
                      </div>

                      <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', margin: '0.35rem 0' }}>
                        <span className={`badge-active ${
                          log.status === 'Healthy' ? 'status-healthy' : 'badge-expired'
                        }`} style={{
                          backgroundColor: log.status === 'Healthy' ? '#DCFCE7' : '#FEF3C7',
                          color: log.status === 'Healthy' ? '#15803D' : '#D97706',
                          fontSize: '0.78rem'
                        }}>
                          {log.status === 'Healthy' ? '🟢 Healthy / स्वस्थ' : '🟡 Needs Attention'}
                        </span>
                        {log.affectedColonies > 0 && (
                          <span style={{ fontSize: '0.78rem', color: 'var(--color-danger)', fontWeight: 600 }}>
                            ({log.affectedColonies} boxes)
                          </span>
                        )}
                      </div>

                      <p className="log-notes" style={{ margin: 0, fontSize: '0.88rem', color: 'var(--color-text-muted)' }}>
                        {log.notes}
                      </p>
                    </div>
                  ))}
                </div>
              </div>
            </div>
          )}

          {/* TAB 6: REMINDERS & AGRICULTURAL TASKS */}
          {activeSubTab === 'reminders' && (
            <div className="health-section-layout">
              {/* New Reminder Form */}
              <div className="form-card" style={{ margin: 0 }}>
                <h3 style={{ fontSize: '1.3rem', fontWeight: 800, marginBottom: '1rem' }}>
                  {primaryLang === 'hi' ? 'नया कार्य अनुस्मारक जोड़ें' : 'Set Hive Task Reminder'}
                </h3>

                <form onSubmit={handleAddReminder}>
                  <div className="form-group">
                    <label className="form-label" htmlFor="rem-title-input">
                      {primaryLang === 'hi' ? 'कार्य का नाम:' : 'Task Title:'}
                    </label>
                    <input 
                      id="rem-title-input"
                      type="text" 
                      className="form-input" 
                      placeholder={primaryLang === 'hi' ? 'उदा. ततैया ट्रैप की जाँच, चीनी घोल पोषण' : 'e.g. Check sugar feed, queen cell inspection'}
                      value={newRemTitle}
                      onChange={(e) => setNewRemTitle(e.target.value)}
                      style={{ height: '52px' }}
                      required
                    />
                  </div>

                  <div className="form-group">
                    <label className="form-label" htmlFor="rem-date-input">
                      {primaryLang === 'hi' ? 'तारीख (Due Date):' : 'Due Date:'}
                    </label>
                    <input 
                      id="rem-date-input"
                      type="date" 
                      className="form-input" 
                      value={newRemDate}
                      onChange={(e) => setNewRemDate(e.target.value)}
                      style={{ height: '52px' }}
                      required
                    />
                  </div>

                  <div className="form-group">
                    <label className="form-label" htmlFor="rem-notes-input">
                      {primaryLang === 'hi' ? 'अतिरिक्त नोट:' : 'Notes:'}
                    </label>
                    <textarea 
                      id="rem-notes-input"
                      className="form-input" 
                      rows="2" 
                      placeholder={primaryLang === 'hi' ? 'जरूरी सावधानियां...' : 'Action steps...'}
                      value={newRemNotes}
                      onChange={(e) => setNewRemNotes(e.target.value)}
                    ></textarea>
                  </div>

                  <button type="submit" className="btn btn-primary" style={{ width: '100%', minHeight: '52px', fontWeight: 800 }}>
                    {primaryLang === 'hi' ? 'अनुस्मारक जोड़ें' : 'Create Reminder'}
                  </button>
                </form>
              </div>

              {/* Reminders Cards List with Urgency Badges */}
              <div className="table-card" style={{ padding: '1.5rem', margin: 0 }}>
                <h3 style={{ fontSize: '1.25rem', fontWeight: 800, marginBottom: '1rem' }}>
                  {primaryLang === 'hi' ? 'अनुसूचित कृषि कार्य' : 'Scheduled Reminders & Tasks'}
                </h3>

                <div style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
                  {reminders.map(rem => (
                    <div 
                      key={rem.id} 
                      className="reminder-card-item"
                      style={{
                        opacity: rem.status === 'Completed' ? 0.65 : 1,
                        borderLeft: rem.urgency === 'high' ? '5px solid var(--color-danger)' : '5px solid var(--color-primary)'
                      }}
                    >
                      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '0.4rem' }}>
                        <span style={{ 
                          fontWeight: 800, 
                          fontSize: '1rem',
                          textDecoration: rem.status === 'Completed' ? 'line-through' : 'none'
                        }}>
                          {rem.title}
                        </span>

                        <span className="badge-due-date" style={{
                          backgroundColor: rem.urgency === 'high' ? '#FEE2E2' : '#FEF3C7',
                          color: rem.urgency === 'high' ? '#B91C1C' : '#D97706'
                        }}>
                          ⏰ {rem.date}
                        </span>
                      </div>

                      <p style={{ fontSize: '0.88rem', color: 'var(--color-text-muted)', marginBottom: '0.75rem' }}>
                        {rem.notes}
                      </p>

                      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                        <span className="badge-active" style={{
                          backgroundColor: rem.status === 'Completed' ? '#DCFCE7' : '#FEF3C7',
                          color: rem.status === 'Completed' ? '#15803D' : '#D97706'
                        }}>
                          {rem.status === 'Completed' ? '✓ Completed (पूर्ण)' : '🟡 Pending (लंबित)'}
                        </span>

                        <button 
                          className="btn btn-secondary btn-sm"
                          onClick={() => handleToggleReminder(rem.id)}
                        >
                          {rem.status === 'Pending' ? 'Mark as Done' : 'Undo'}
                        </button>
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            </div>
          )}

          {/* TAB 7: AUDIT HISTORY */}
          {activeSubTab === 'history' && (
            <div>
              <h2 style={{ fontSize: '1.5rem', fontWeight: 800, marginBottom: '1rem' }}>
                {primaryLang === 'hi' ? 'खाता ऑडिट एवं कार्य इतिहास' : 'Audit Logs & Operation History'}
              </h2>
              <div className="history-list">
                {history.map(item => (
                  <div key={item.id} className="history-item">
                    <div className="history-time">
                      {new Date(item.timestamp).toLocaleString()}
                    </div>
                    <div className="history-info">
                      <div className="history-type">{item.type}</div>
                      <div className="history-desc">{item.details}</div>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          )}

        </div>
      </main>

      {/* MOBILE BOTTOM NAVIGATION BAR (Mandatory for rural farmer device) */}
      <nav className="mobile-bottom-nav">
        {/* Tab 1: Overview */}
        <button 
          className={`mobile-nav-item ${activeSubTab === 'overview' ? 'active' : ''}`}
          onClick={() => setActiveSubTab('overview')}
        >
          <LayoutDashboard size={22} />
          <span>{primaryLang === 'hi' ? 'डैशबोर्ड' : 'Overview'}</span>
        </button>

        {/* Tab 2: My Harvests */}
        <button 
          className={`mobile-nav-item ${activeSubTab === 'harvests' ? 'active' : ''}`}
          onClick={() => setActiveSubTab('harvests')}
        >
          <span style={{ fontSize: '1.3rem' }}>🍯</span>
          <span>{primaryLang === 'hi' ? 'मेरी फसल' : 'Harvests'}</span>
        </button>

        {/* Tab 3: CREATE HARVEST (Center Highlighted Gold Button) */}
        <button 
          className="mobile-nav-item mobile-nav-center-highlight"
          onClick={() => { resetHarvestForm(); setActiveSubTab('create-harvest'); }}
        >
          <div className="mobile-center-circle">
            <PlusCircle size={28} />
          </div>
          <span style={{ fontWeight: 800, color: 'var(--color-primary-dark)' }}>
            {primaryLang === 'hi' ? 'नया शहद' : 'Add Harvest'}
          </span>
        </button>

        {/* Tab 4: Apiaries */}
        <button 
          className={`mobile-nav-item ${activeSubTab === 'apiaries' ? 'active' : ''}`}
          onClick={() => setActiveSubTab('apiaries')}
        >
          <Compass size={22} />
          <span>{primaryLang === 'hi' ? 'पेटियां' : 'Apiaries'}</span>
        </button>

        {/* Tab 5: Health */}
        <button 
          className={`mobile-nav-item ${activeSubTab === 'health' ? 'active' : ''}`}
          onClick={() => setActiveSubTab('health')}
        >
          <Activity size={22} />
          <span>{primaryLang === 'hi' ? 'स्वास्थ्य' : 'Health'}</span>
        </button>

        {/* Tab 6: Reminders */}
        <button 
          className={`mobile-nav-item ${activeSubTab === 'reminders' ? 'active' : ''}`}
          onClick={() => setActiveSubTab('reminders')}
        >
          <Bell size={22} />
          <span>{primaryLang === 'hi' ? 'याद दिलाएं' : 'Alerts'}</span>
        </button>
      </nav>

      {/* MOVE / SPLIT COLONIES MODAL */}
      {showMoveModal && activeApiaryForMove && (
        <div className="modal-overlay">
          <div className="modal-content" style={{ maxWidth: '520px' }}>
            <div className="modal-header">
              <h3 style={{ fontSize: '1.3rem', fontWeight: 800 }}>
                {primaryLang === 'hi' ? 'पेटी प्रवास / विभाजन (Flora Migration)' : 'Move or Split Colony Group'}
              </h3>
              <button style={{ background: 'none', border: 'none', cursor: 'pointer' }} onClick={() => setShowMoveModal(false)}>
                <X size={20} />
              </button>
            </div>

            <div style={{ backgroundColor: '#FDFBF7', padding: '1rem', borderRadius: 'var(--radius-md)', marginBottom: '1.25rem', border: '1px solid var(--color-border)' }}>
              <strong>{activeApiaryForMove.name}</strong>
              <div style={{ fontSize: '0.85rem', color: 'var(--color-text-muted)', marginTop: '0.25rem' }}>
                {primaryLang === 'hi' ? `कुल पेटियां: ${activeApiaryForMove.hiveCount} इकाइयां | वर्तमान GPS: ${activeApiaryForMove.gps}` : `Total Hives: ${activeApiaryForMove.hiveCount} boxes`}
              </div>
            </div>

            <div className="form-group">
              <label className="form-label" style={{ fontWeight: 700 }}>
                {primaryLang === 'hi' ? 'प्रवास का प्रकार चुनें:' : 'Select Movement Type:'}
              </label>
              
              <div style={{ display: 'flex', flexDirection: 'column', gap: '0.75rem', marginTop: '0.5rem' }}>
                <label className="tamper-toggle-label" style={{ padding: '0.75rem', border: '1px solid var(--color-border)', borderRadius: 'var(--radius-sm)', cursor: 'pointer' }}>
                  <input 
                    type="radio" 
                    name="move-type" 
                    checked={moveType === 'all'} 
                    onChange={() => setMoveType('all')} 
                  />
                  <span>
                    <strong>{primaryLang === 'hi' ? 'सभी पेटियां नए स्थान पर ले जाएं' : 'Move ALL colonies'}</strong>
                    <div style={{ fontSize: '0.78rem', color: 'var(--color-text-muted)' }}>
                      {primaryLang === 'hi' ? 'मौजूदा स्थान का GPS निर्देशांक अपडेट होगा' : 'Updates GPS coordinates for migration'}
                    </div>
                  </span>
                </label>

                <label className="tamper-toggle-label" style={{ padding: '0.75rem', border: '1px solid var(--color-border)', borderRadius: 'var(--radius-sm)', cursor: 'pointer' }}>
                  <input 
                    type="radio" 
                    name="move-type" 
                    checked={moveType === 'some'} 
                    onChange={() => setMoveType('some')} 
                  />
                  <span>
                    <strong>{primaryLang === 'hi' ? 'कुछ पेटियां अलग करें (विभाजन / Split)' : 'Split some colonies into new site'}</strong>
                    <div style={{ fontSize: '0.78rem', color: 'var(--color-text-muted)' }}>
                      {primaryLang === 'hi' ? 'नया Location ID बनेगा और पेटियां विभाजित होंगी' : 'Creates new Location ID and transfers count'}
                    </div>
                  </span>
                </label>
              </div>
            </div>

            {moveType === 'some' && (
              <div className="form-group">
                <label className="form-label" htmlFor="split-count-input">
                  {primaryLang === 'hi' ? 'कितनी पेटियां अलग करनी हैं?' : 'Number of boxes to move:'}
                </label>
                <input 
                  id="split-count-input"
                  type="number" 
                  className="form-input" 
                  min="1" 
                  max={activeApiaryForMove.hiveCount - 1} 
                  value={moveCount} 
                  onChange={(e) => setMoveCount(e.target.value)} 
                  style={{ height: '50px', fontSize: '1.1rem' }}
                />
              </div>
            )}

            <div className="form-group">
              <label className="form-label" htmlFor="move-new-gps">
                {primaryLang === 'hi' ? 'नया GPS निर्देशांक (latitude, longitude):' : 'New GPS Coordinates:'}
              </label>
              <input 
                id="move-new-gps"
                type="text" 
                className="form-input" 
                placeholder="e.g. 27.5530, 76.6346 (Alwar, Rajasthan)" 
                value={newGps}
                onChange={(e) => setNewGps(e.target.value)}
                style={{ height: '50px' }}
                required
              />
            </div>

            <div className="modal-footer">
              <button className="btn btn-secondary" onClick={() => setShowMoveModal(false)}>
                {primaryLang === 'hi' ? 'रद्द करें' : 'Cancel'}
              </button>
              <button className="btn btn-green" onClick={handleExecuteMove}>
                {primaryLang === 'hi' ? 'प्रवास की पुष्टि करें' : 'Confirm Movement'}
              </button>
            </div>
          </div>
        </div>
      )}

    </div>
  );
}
