import React, { useState, useEffect } from 'react';
import { 
  Hexagon, LayoutDashboard, PlusCircle, Compass, Clipboard, 
  Bell, LogOut, ShieldCheck, MapPin, Layers, 
  Activity, Check, FileText, Upload, Calendar, X,
  Camera, Mic, MicOff, Volume2, Sparkles, QrCode, ArrowRight,
  ArrowLeft, CheckCircle2, AlertTriangle, Printer,
  ChevronRight, RefreshCw, Thermometer, Droplets, Radio, Eye
} from 'lucide-react';
import { QRCodeSVG as QRCode } from 'qrcode.react';
import SpeakerButton from '../components/SpeakerButton';
import { INITIAL_IOT_READINGS } from '../data/mockData';
import { evaluateEnvironmentalStatus, getSensorForLocation, IOT_THRESHOLDS } from '../utils/iotConfig';

export default function BeekeeperDashboard({ 
  user, setView, harvests, setHarvests, apiaries, setApiaries, 
  healthLogs, setHealthLogs, reminders = [], setReminders, history, setHistory,
  setActiveTraceId, primaryLang = 'hi'
}) {
  // Mobile / Sub-tab navigation: 'overview', 'harvests', 'create-harvest', 'apiaries', 'health', 'reminders'
  const [activeSubTab, setActiveSubTab] = useState('overview');
  
  // Guided Wizard Step for Create Harvest (1 to 6)
const [ulrNumber, setUlrNumber] = useState("");

const [ulrStatus, setUlrStatus] = useState(null);
// null = not checked
// "checking" = checking database
// "verified" = valid ULR
// "invalid" = ULR not found
  const [wizardStep, setWizardStep] = useState(1);
  const [selectedApiaryId, setSelectedApiaryId] = useState(apiaries[0]?.locationId || 'LOC-001');
  const [harvestDate, setHarvestDate] = useState(new Date().toISOString().split('T')[0]);
  const [selectedFlowers, setSelectedFlowers] = useState(['Mustard']);
  const [customFlower, setCustomFlower] = useState('');
  const [customLocationText, setCustomLocationText] = useState('');
  const [harvestQuantity, setHarvestQuantity] = useState(160);
  const [labName, setLabName] = useState('Demo Honey Testing Laboratory (NABL #104)');
  const [labVerificationError, setLabVerificationError] = useState('');
  const [labReportFile, setLabReportFile] = useState(null);
  const [labPhotoCaptured, setLabPhotoCaptured] = useState(false);
  const [gpsDetecting, setGpsDetecting] = useState(false);
  const [gpsDetected, setGpsDetected] = useState('Location not set yet');
  const [gpsCoordinates, setGpsCoordinates] = useState(null);
  
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

  // AI Bee Disease Detection State
const [aiImage, setAiImage] = useState(null);
const [aiPreview, setAiPreview] = useState('');
const [aiResult, setAiResult] = useState(null);
const [aiLoading, setAiLoading] = useState(false);
const [aiError, setAiError] = useState('');

  // Reminders State
  const [newRemTitle, setNewRemTitle] = useState('');
  const [newRemDate, setNewRemDate] = useState('');
  const [newRemNotes, setNewRemNotes] = useState('');

  // IoT Environmental Monitoring State
  const [iotReadings, setIotReadings] = useState(INITIAL_IOT_READINGS);
  const [selectedIotLocationId, setSelectedIotLocationId] = useState('LOC-001');
  const [healthLogFilter, setHealthLogFilter] = useState('all'); // 'all' (combined timeline), 'manual', 'iot'

  // Fetch IoT readings from backend API (falls back gracefully to INITIAL_IOT_READINGS)
  useEffect(() => {
    const fetchIotReadings = async () => {
      try {
        const response = await fetch('/api/iot/readings');
        if (response.ok) {
          const result = await response.json();
          if (result.success && Array.isArray(result.data) && result.data.length > 0) {
            setIotReadings(result.data);
          }
        }
      } catch (err) {
        console.warn('Could not fetch IoT readings from API, using seeded values:', err);
      }
    };

    fetchIotReadings();
  }, []);

  const persistReminderStorage = (nextReminders) => {
    if (!user?.beekeeperId) return;
    const storageKey = `honeychain_alerts_${user.beekeeperId}`;
    localStorage.setItem(storageKey, JSON.stringify(nextReminders));
  };

  useEffect(() => {
    if (!user?.beekeeperId) return;

    const storageKey = `honeychain_alerts_${user.beekeeperId}`;

    try {
      const saved = localStorage.getItem(storageKey);
      if (saved) {
        const parsed = JSON.parse(saved);
        setReminders(Array.isArray(parsed) ? parsed : []);
      } else {
        setReminders([]);
      }
    } catch (error) {
      console.error('Failed to load saved reminders:', error);
      setReminders([]);
    }
  }, [user?.beekeeperId, setReminders]);

  // Floral options with rich icons
  const flowerOptions = [
    { id: "Mustard", nameEn: "Mustard", nameHi: "सरसों", icon: "🌼" },
    { id: "Eucalyptus", nameEn: "Eucalyptus", nameHi: "यूकेलिप्टस / सफेदा", icon: "🌿" },
    { id: "Acacia", nameEn: "Acacia (Kikar)", nameHi: "किकर / बबूल", icon: "🌳" },
    { id: "Litchi", nameEn: "Litchi", nameHi: "लीची", icon: "🍒" },
    { id: "Sunflower", nameEn: "Sunflower", nameHi: "सूरजमुखी", icon: "🌻" },
    { id: "Multifloral", nameEn: "Multifloral", nameHi: "बहुपुष्पी (जंगली फूल)", icon: "💐" }
  ];
const handleVerifyULR = async () => {
    if (!ulrNumber.trim()) {
      setUlrStatus("invalid");
      setLabVerificationError("ULR ID must be verified before continuing.");
      return;
    }

    try {
        setUlrStatus("checking");
        setLabVerificationError('');

        const response = await fetch(
            "/api/verify-ulr",
            {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({
                    ulrNumber: ulrNumber
                })
            }
        );

        const data = await response.json();

        console.log("ULR verification:", data);

        if (data.verified) {
            // ULR exists
            setLabName(data.lab.lab_name);
            setUlrStatus("verified");
            setLabVerificationError('');
        } else {
            // ULR doesn't exist
            setUlrStatus("invalid");
            setLabVerificationError("ULR ID must be verified before continuing.");
            alert("Invalid ULR Number");
        }

    } catch (error) {
        console.error("ULR verification error:", error);
        setUlrStatus("invalid");
        setLabVerificationError("ULR ID must be verified before continuing.");
        alert("Could not connect to the server");
    }
};
const handleAddNewLocationBackend = async () => {
    const name = prompt("Enter Apiary Site Name (स्थान का नाम):", `Apiary - New Flora`);
    const count = prompt("Initial Hive Count (पेटियों की संख्या):", "8");
    const gps = prompt("GPS Coordinate (जीपीएस निर्देशांक):", "28.8500, 79.1000");

    if (name && count) {
      // 👇 Bind the ID to the specific Beekeeper ID + a timestamp to ensure zero conflicts
      const newLocId = `LOC-${user.beekeeperId}-${Date.now().toString().slice(-4)}`;

      try {
        const response = await fetch('/api/locations', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            location_id: newLocId,
            beekeeper_id: user.beekeeperId,
            name: name, // 👈 Pass the name here
            gps_coordinates: gps || "28.8500, 79.1000",
            hive_count: parseInt(count) || 6
          })
        });

        const result = await response.json();

        if (result.success) {
          alert("Success! Location saved to database.");
          
          const newAp = {
            locationId: newLocId,
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
        } else {
          alert("Database Error: " + result.error);
        }
      } catch (error) {
        console.error("Fetch failed:", error);
        alert("Could not connect to the database server.");
      }
    }
  };
  const handleFlowerToggle = (flowerId) => {
    if (selectedFlowers.includes(flowerId)) {
      if (selectedFlowers.length > 1) {
        setSelectedFlowers(selectedFlowers.filter(f => f !== flowerId));
      }
    } else {
      setSelectedFlowers([...selectedFlowers, flowerId]);
    }
  };

  // GPS Auto-detect using the browser's real geolocation API.
  const handleAutoDetectGps = () => {
    if (!navigator.geolocation) {
      setGpsDetected('Geolocation is not supported by this browser.');
      return;
    }

    setGpsDetecting(true);
    setGpsCoordinates(null);

    navigator.geolocation.getCurrentPosition(
      (position) => {
        const latitude = position.coords.latitude;
        const longitude = position.coords.longitude;
        const currentCoords = `${latitude.toFixed(6)}, ${longitude.toFixed(6)}`;

        setGpsCoordinates({ latitude, longitude });
        setGpsDetected(`${currentCoords} (Current location)`);
        setGpsDetecting(false);
      },
      (error) => {
        const messageMap = {
          1: 'Location permission denied. Please allow access and retry.',
          2: 'Location unavailable. Please try again.',
          3: 'Location request timed out. Please try again.'
        };

        setGpsDetected(messageMap[error.code] || 'Unable to determine your current location. Please try again.');
        setGpsDetecting(false);
      },
      {
        enableHighAccuracy: true,
        timeout: 15000,
        maximumAge: 0
      }
    );
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
const startVerificationProcess = async () => {
    setWizardStep(6);
    setVerificationStep(1);
    
    setTimeout(() => {
      setVerificationStep(2);
      
      setTimeout(async () => {
        setVerificationStep(3);
        
        setTimeout(async () => {
          setVerificationStep(4);
          
          // Generate Harvest ID
          const targetApiary = apiaries.find(a => a.locationId === selectedApiaryId);
          const dateStr = harvestDate.replace(/-/g, '');
          const newHarvestId = `HB-${user.beekeeperId}-${dateStr}-${Date.now().toString().slice(-4)}`;

          const newHarvestPayload = {
            harvest_id: newHarvestId,
            beekeeper_id: user.beekeeperId,
            harvest_date: harvestDate,
            flower_sources: selectedFlowers,
            location_id: selectedApiaryId,
            gps_coordinates: gpsCoordinates ? `${gpsCoordinates.latitude.toFixed(6)}, ${gpsCoordinates.longitude.toFixed(6)}` : null,
            lab_ulr: ulrNumber || null,
            ulr_status: ulrStatus || "Verified",
            quantity_kg: Number(harvestQuantity) || 0
          };

          try {
            const response = await fetch('/api/harvests', {
              method: 'POST',
              headers: { 'Content-Type': 'application/json' },
              body: JSON.stringify(newHarvestPayload)
            });
            const dbResult = await response.json();

            if (!response.ok || !dbResult.success) {
              throw new Error(dbResult.error || dbResult.message || 'Failed to create harvest');
            }

            const savedHarvest = databaseHarvestToUIHarvest(dbResult.data || {
              harvest_id: newHarvestId,
              beekeeper_id: user.beekeeperId,
              harvest_date: harvestDate,
              flower_sources: selectedFlowers,
              location_id: selectedApiaryId,
              lab_ulr: ulrNumber || null,
              ulr_status: ulrStatus || 'Verified',
              block_hash: null,
              tx_ref: null,
              quantity_kg: Number(harvestQuantity) || 0,
              location_name: customLocationText || (targetApiary ? targetApiary.name : 'Rampur Apiary')
            });

            setTimeout(() => {
              setVerificationStep(5);
              setCreatedHarvestId(newHarvestId);

              setHarvests(prev => [savedHarvest, ...prev]);

            }, 900);
          } catch (err) {
            console.error('Failed to persist harvest to PostgreSQL:', err);
            alert(`Could not save harvest to database: ${err.message}`);
            setVerificationStep(0);
            return;
          }
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
    setHarvestQuantity(160);
    setGpsCoordinates(null);
    setGpsDetected('Location not set yet');
    setLabReportFile(null);
    setLabPhotoCaptured(false);
    setLabVerificationError('');
    
    // 👇 ADD THESE THREE LINES TO PREVENT DUPLICATE DATABASE ERRORS
    setUlrNumber('');
    setUlrStatus(null);
    setLabName('Demo Honey Testing Laboratory (NABL #104)');
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

  const normalizeFlowerSources = (value) => {
    if (Array.isArray(value)) {
      return value.filter(Boolean);
    }

    if (!value) {
      return [];
    }

    if (typeof value === 'string') {
      try {
        const parsed = JSON.parse(value);
        if (Array.isArray(parsed)) {
          return parsed.filter(Boolean);
        }
      } catch (error) {
        // Fall back to comma-split if JSON parse fails.
      }

      return value
        .split(',')
        .map(item => item.trim())
        .filter(Boolean);
    }

    return [String(value)];
  };

  const databaseHarvestToUIHarvest = (row = {}) => ({
    harvestId: row.harvest_id || row.harvestId || '',
    beekeeperId: row.beekeeper_id || row.beekeeperId || '',
    beekeeperName: row.beekeeper_name || row.beekeeperName || user?.registeredName || '',
    state: row.state || 'Uttar Pradesh',
    harvestDate: row.harvest_date || row.harvestDate || '',
    flowerSources: normalizeFlowerSources(row.flower_sources ?? row.flowerSources ?? []),
    locationId: row.location_id || row.locationId || '',
    locationName: row.location_name || row.locationName || 'Apiary',
    gps: row.gps || row.gps_coordinates || '',
    labName: row.lab_name || row.labName || 'Demo Honey Testing Laboratory (NABL #104)',
    labStatus: row.lab_status || row.labStatus || 'Verified',
    blockchainStatus: row.blockchain_status || row.blockchainStatus || 'Verified',
    moisture: row.moisture || '17.4%',
    hash: row.block_hash || row.hash || '',
    txRef: row.tx_ref || row.txRef || '',
    quantityKg: Number(row.quantity_kg ?? row.quantityKg ?? 160),
    ulrNumber: row.lab_ulr || row.labUlr || '',
  });

useEffect(() => {
  const fetchApiaries = async () => {
    try {
      const response = await fetch(
        `/api/locations/${user.beekeeperId}`
      );

      if (!response.ok) {
        throw new Error(`HTTP ${response.status}`);
      }

      const result = await response.json();

      console.log("Apiaries received from PostgreSQL:", result);

      // Backend currently returns the array directly.
      // Also supports { success: true, data: [...] } if the backend
      // is changed to that format later.
      const apiaryRows = Array.isArray(result)
        ? result
        : result?.data || [];

      const mappedApiaries = apiaryRows.map(ap => ({
        locationId: ap.location_id,
        name: ap.name || `Apiary ${ap.location_id}`,
        gps: ap.gps_coordinates || "28.8500, 79.1000",
        hiveCount: Number(ap.hive_count) || 0,
        villageName: ap.village_name || "Registered Zone",
        flora: ap.flora || "Multifloral Blooms",
        status: ap.status || "Healthy",
        lastInspection: ap.last_inspection
          ? ap.last_inspection.split('T')[0]
          : new Date().toISOString().split('T')[0],
        notes: ap.notes || "Active database record"
      }));

      console.log("Mapped apiaries for dashboard:", mappedApiaries);

      setApiaries(mappedApiaries);

    } catch (err) {
      console.error(
        "Failed to load apiaries from PostgreSQL:",
        err
      );
    }
  };

  if (user?.beekeeperId) {
    fetchApiaries();
  }
}, [user?.beekeeperId, setApiaries]);

useEffect(() => {
  if (apiaries.length > 0) {
    const firstApiaryId = apiaries[0].locationId;

    setSelectedApiaryId(prev =>
      apiaries.some(a => a.locationId === prev)
        ? prev
        : firstApiaryId
    );

    setLogApiaryId(prev =>
      apiaries.some(a => a.locationId === prev)
        ? prev
        : firstApiaryId
    );
  }
}, [apiaries]);

  useEffect(() => {
    const fetchHealthLogs = async () => {
      if (!user?.beekeeperId) {
        setHealthLogs([]);
        return;
      }

      try {
        const response = await fetch(`/api/health-logs/${encodeURIComponent(user.beekeeperId)}`);
        const result = await response.json();

        if (!response.ok || !result.success) {
          throw new Error(result.error || result.message || 'Failed to load health logs');
        }

        const mappedLogs = (Array.isArray(result.data) ? result.data : []).map(log => mapHealthLogFromDatabase(log, apiaries));
        setHealthLogs(mappedLogs);
      } catch (error) {
        console.error('Failed to load health logs from PostgreSQL:', error);
        setHealthLogs([]);
      }
    };

    fetchHealthLogs();
  }, [user?.beekeeperId, apiaries, setHealthLogs]);

  // Load harvests from PostgreSQL whenever the authenticated beekeeper dashboard opens.
  useEffect(() => {
    const fetchHarvests = async () => {
      if (!user?.beekeeperId) {
        setHarvests([]);
        return;
      }

      try {
        const response = await fetch(`/api/harvests/${encodeURIComponent(user.beekeeperId)}`);
        const result = await response.json();

        if (!response.ok || !result.success) {
          throw new Error(result.error || result.message || 'Failed to load harvests');
        }

        const rows = Array.isArray(result.data) ? result.data : [];
        const mappedHarvests = rows.map(databaseHarvestToUIHarvest);
        setHarvests(mappedHarvests);
      } catch (error) {
        console.error('Failed to load harvests from PostgreSQL:', error);
        setHarvests([]);
      }
    };

    fetchHarvests();
  }, [user?.beekeeperId, setHarvests]);

  const handleUseCurrentLocationForMove = () => {
    if (!navigator.geolocation) {
      alert(primaryLang === 'hi'
        ? 'यह ब्राउज़र वर्तमान स्थान का उपयोग नहीं करता है। कृपया मैन्युअल GPS निर्देशांक दर्ज करें।'
        : 'Current location is not supported in this browser. Please enter GPS coordinates manually.');
      return;
    }

    navigator.geolocation.getCurrentPosition(
      (position) => {
        const latitude = position.coords.latitude;
        const longitude = position.coords.longitude;
        const formattedGps = `${latitude.toFixed(6)}, ${longitude.toFixed(6)}`;
        setNewGps(formattedGps);
      },
      (error) => {
        const messageMap = {
          1: primaryLang === 'hi'
            ? 'स्थान की अनुमति अस्वीकार की गई। कृपया स्थान एक्सेस की अनुमति दें या मैन्युअल GPS निर्देशांक दर्ज करें।'
            : 'Location permission was denied. Please allow location access or enter the GPS coordinates manually.',
          2: primaryLang === 'hi'
            ? 'वर्तमान स्थान निर्धारित नहीं किया जा सका। कृपया GPS निर्देशांक मैन्युअल रूप से दर्ज करें।'
            : 'Current location could not be determined. Please enter GPS coordinates manually.',
          3: primaryLang === 'hi'
            ? 'स्थान अनुरोध का समय समाप्त हो गया। कृपया फिर से प्रयास करें या मैन्युअल GPS दर्ज करें।'
            : 'Location request timed out. Please try again or enter GPS coordinates manually.'
        };

        alert(messageMap[error.code] || (primaryLang === 'hi'
          ? 'वर्तमान स्थान निर्धारित नहीं किया जा सका। कृपया GPS निर्देशांक मैन्युअल रूप से दर्ज करें।'
          : 'Current location could not be determined. Please enter GPS coordinates manually.'));
      },
      {
        enableHighAccuracy: true,
        timeout: 15000,
        maximumAge: 0
      }
    );
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

    }

    setShowMoveModal(false);
  };

  // Add Health Log Logic
// Add Health Log Logic (Connected to Database)
  const mapHealthLogFromDatabase = (log, apiaryList = []) => {
    const targetApiary = apiaryList.find(a => a.locationId === (log.location_id || log.locationId));
    const inspectionDate = log.inspection_date || log.inspectionDate || new Date().toISOString().split('T')[0];

    return {
      id: log.id,
      locationId: log.location_id || log.locationId,
      apiaryName: targetApiary?.name || log.location_name || log.apiaryName || 'Apiary',
      date: inspectionDate.split('T')[0],
      status: log.status || 'Healthy',
      statusHi: log.status === 'Healthy'
        ? 'स्वस्थ (सब ठीक है)'
        : log.status === 'Needs Attention'
          ? 'ध्यान दें (कीट/ततैया)'
          : 'खतरा (तुरंत ध्यान दें)',
      affectedColonies: Number(log.affected_colonies ?? log.affectedColonies ?? 0),
      notes: log.notes || 'नियमित निरीक्षण पूर्ण। सब ठीक है।',
      inspectionDate,
      createdAt: log.created_at || log.createdAt || null
    };
  };
// ==========================================
// AI BEE DISEASE DETECTION
// ==========================================

const handleAiImageChange = (event) => {
  const file = event.target.files?.[0];

  if (!file) return;

  setAiImage(file);
  setAiPreview(URL.createObjectURL(file));
  setAiResult(null);
  setAiError('');
};

const handleAiPrediction = async () => {
  if (!aiImage) {
    setAiError('Please select a bee image first.');
    return;
  }

  setAiLoading(true);
  setAiError('');
  setAiResult(null);

  try {
    const formData = new FormData();
    formData.append('image', aiImage);

    const response = await fetch('/api/ai/predict', {
      method: 'POST',
      body: formData,
    });

    const data = await response.json();

    if (!response.ok || !data.success) {
      throw new Error(data.error || 'AI prediction failed.');
    }

    setAiResult(data);
  } catch (error) {
    setAiError(
      error.message || 'Could not analyze the bee image.'
    );
  } finally {
    setAiLoading(false);
  }
};
  const handleAddHealthLog = async (e) => {
    e.preventDefault();
    const targetApiary = apiaries.find(a => a.locationId === logApiaryId);
    if (!targetApiary) return;

    try {
      const response = await fetch('/api/health-logs', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          location_id: logApiaryId,
          status: logStatus,
          notes: logNotes || "नियमित निरीक्षण पूर्ण। सब ठीक है।",
          inspection_date: new Date().toISOString().split('T')[0]
        })
      });

      const result = await response.json();

      if (!response.ok || !result.success) {
        throw new Error(result.error || result.message || 'Failed to create health log');
      }

      const savedLog = mapHealthLogFromDatabase(result.data, apiaries);
      setHealthLogs(prev => [savedLog, ...prev]);

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

      setLogColonies(0);
      setLogNotes('');
      setVoiceRecorded(false);
      alert(primaryLang === 'hi' ? "स्वास्थ्य रिकॉर्ड सफलतापूर्वक सुरक्षित हुआ!" : "Health log saved to database successfully!");
    } catch (error) {
      console.error("Failed to save health log to PostgreSQL:", error);
      alert(`Could not save health log: ${error.message}`);
    }
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

    setReminders(prev => {
      const updated = [newRem, ...prev];
      persistReminderStorage(updated);
      return updated;
    });
    setNewRemTitle('');
    setNewRemDate('');
    setNewRemNotes('');
    alert(primaryLang === 'hi' ? "कार्य अनुस्मारक जोड़ा गया!" : "Reminder added!");
  };

  const handleToggleReminder = (id) => {
    setReminders(prev => {
      const updated = prev.map(r => {
        if (r.id === id) {
          return { ...r, status: r.status === 'Pending' ? 'Completed' : 'Pending' };
        }
        return r;
      });
      persistReminderStorage(updated);
      return updated;
    });
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

              {/* 5. IOT ENVIRONMENTAL MONITORING WIDGET (Overview Section) */}
              {(() => {
                const targetLocId = selectedIotLocationId || apiaries[0]?.locationId || 'LOC-001';
                const activeApiary = apiaries.find(a => a.locationId === targetLocId) || apiaries[0] || { name: 'Apiary 1', locationId: 'LOC-001' };
                const locReadings = iotReadings.filter(r => (r.locationId || r.location_id) === targetLocId);
                const latestReading = locReadings[0] || {
                  temperature: 31.4,
                  humidity: 68,
                  timestamp: new Date().toISOString(),
                  sensorId: getSensorForLocation(targetLocId).sensorId
                };
                const envStatus = evaluateEnvironmentalStatus(latestReading.temperature, latestReading.humidity);
                const sensorMeta = getSensorForLocation(targetLocId);
                const readingTime = new Date(latestReading.timestamp).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });

                return (
                  <div className="iot-monitoring-section">
                    <div className="iot-section-header">
                      <div style={{ display: 'flex', alignItems: 'center', gap: '0.6rem' }}>
                        <Radio size={20} style={{ color: 'var(--color-primary-dark)' }} />
                        <div>
                          <h3 style={{ fontSize: '1.2rem', fontWeight: 800, margin: 0 }}>
                            {primaryLang === 'hi' ? 'पर्यावरण एवं सेंसर निगरानी (IoT Environmental Monitoring)' : 'Environmental Monitoring'}
                          </h3>
                          <span style={{ fontSize: '0.8rem', color: 'var(--color-text-light)' }}>
                            {primaryLang === 'hi' ? 'हवा का तापमान व आर्द्रता — स्वचालित सेंसर डेटा' : 'Live temperature & humidity telemetry from apiary sensor'}
                          </span>
                        </div>
                      </div>

                      {apiaries.length > 1 && (
                        <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                          <span style={{ fontSize: '0.82rem', fontWeight: 700, color: 'var(--color-text-muted)' }}>
                            {primaryLang === 'hi' ? 'स्थान:' : 'Site:'}
                          </span>
                          <select
                            className="form-input"
                            style={{ height: '36px', padding: '0.2rem 0.6rem', fontSize: '0.85rem' }}
                            value={targetLocId}
                            onChange={(e) => setSelectedIotLocationId(e.target.value)}
                          >
                            {apiaries.map(a => (
                              <option key={a.locationId} value={a.locationId}>{a.name}</option>
                            ))}
                          </select>
                        </div>
                      )}
                    </div>

                    <div className="iot-metrics-grid">
                      {/* Temperature Box */}
                      <div className="iot-metric-box">
                        <div className="iot-metric-header">
                          <span className="iot-metric-label">{primaryLang === 'hi' ? 'तापमान (Temperature)' : 'Temperature'}</span>
                          <Thermometer size={16} style={{ color: 'var(--color-primary-dark)' }} />
                        </div>
                        <div className="iot-metric-val">{Number(latestReading.temperature).toFixed(1)} °C</div>
                        <div style={{ marginTop: '0.4rem' }}>
                          <span className={`iot-status-pill ${Number(latestReading.temperature) >= IOT_THRESHOLDS.temperature.min && Number(latestReading.temperature) <= IOT_THRESHOLDS.temperature.max ? 'iot-status-normal' : 'iot-status-warning'}`}>
                            {Number(latestReading.temperature) >= IOT_THRESHOLDS.temperature.min && Number(latestReading.temperature) <= IOT_THRESHOLDS.temperature.max
                              ? (primaryLang === 'hi' ? '🟢 सामान्य (Normal)' : 'Normal')
                              : (primaryLang === 'hi' ? '🟡 चेतावनी (Warning)' : 'Warning')}
                          </span>
                        </div>
                      </div>

                      {/* Humidity Box */}
                      <div className="iot-metric-box">
                        <div className="iot-metric-header">
                          <span className="iot-metric-label">{primaryLang === 'hi' ? 'आर्द्रता (Humidity)' : 'Humidity'}</span>
                          <Droplets size={16} style={{ color: 'var(--color-secondary)' }} />
                        </div>
                        <div className="iot-metric-val">{Math.round(latestReading.humidity)}%</div>
                        <div style={{ marginTop: '0.4rem' }}>
                          <span className={`iot-status-pill ${Number(latestReading.humidity) >= IOT_THRESHOLDS.humidity.min && Number(latestReading.humidity) <= IOT_THRESHOLDS.humidity.max ? 'iot-status-normal' : 'iot-status-warning'}`}>
                            {Number(latestReading.humidity) >= IOT_THRESHOLDS.humidity.min && Number(latestReading.humidity) <= IOT_THRESHOLDS.humidity.max
                              ? (primaryLang === 'hi' ? '🟢 सामान्य (Normal)' : 'Normal')
                              : (primaryLang === 'hi' ? '🟡 चेतावनी (Warning)' : 'Warning')}
                          </span>
                        </div>
                      </div>

                      {/* Sensor & Location Info */}
                      <div className="iot-metric-box">
                        <div className="iot-metric-header">
                          <span className="iot-metric-label">{primaryLang === 'hi' ? 'सेंसर पहचान' : 'Sensor'}</span>
                          <Radio size={16} style={{ color: '#6366F1' }} />
                        </div>
                        <div style={{ fontWeight: 800, fontSize: '1.05rem', color: 'var(--color-text-main)', marginTop: '0.2rem' }}>
                          {latestReading.sensorId || sensorMeta.sensorId}
                        </div>
                        <div style={{ fontSize: '0.78rem', color: 'var(--color-text-light)', marginTop: '0.35rem' }}>
                          {sensorMeta.model}
                        </div>
                      </div>

                      {/* Apiary & Update Status */}
                      <div className="iot-metric-box">
                        <div className="iot-metric-header">
                          <span className="iot-metric-label">{primaryLang === 'hi' ? 'स्थान एवं समय' : 'Apiary'}</span>
                          <Compass size={16} style={{ color: 'var(--color-secondary)' }} />
                        </div>
                        <div style={{ fontWeight: 800, fontSize: '0.95rem', color: 'var(--color-text-main)', marginTop: '0.2rem' }}>
                          {activeApiary.name}
                        </div>
                        <div style={{ fontSize: '0.78rem', color: 'var(--color-text-light)', marginTop: '0.35rem' }}>
                          {primaryLang === 'hi' ? `अंतिम अपडेट: ${readingTime}` : `Last updated: ${readingTime}`}
                        </div>
                      </div>
                    </div>

                    <div className="iot-meta-row">
                      <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                        <span className="iot-source-badge badge-source-iot">
                          📡 {primaryLang === 'hi' ? 'IoT स्वचालित टेलीमेट्री' : 'IoT Sensor Telemetry'}
                        </span>
                        <span>{primaryLang === 'hi' ? `स्थिति: ${envStatus.statusHi}` : `Environmental Status: ${envStatus.status}`}</span>
                      </div>
                      <span style={{ fontSize: '0.75rem', color: 'var(--color-text-light)' }}>
                        {primaryLang === 'hi' ? 'मानक दायरा: तापमान 30°C - 36°C | नमी 50% - 70%' : 'Configured Range: 30°C - 36°C | 50% - 70% RH'}
                      </span>
                    </div>
                  </div>
                );
              })()}

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
                        <div>{gpsDetecting ? (primaryLang === 'hi' ? 'जीपीएस खोजा जा रहा है...' : 'Detecting GPS...') : (primaryLang === 'hi' ? '📍 वर्तमान स्थान का उपयोग करें' : '📍 Use Current Location')}</div>
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

                    <div className="form-group" style={{ marginTop: '1.25rem' }}>
                      <label className="form-label" htmlFor="harvest-quantity-input">
                        {primaryLang === 'hi' ? 'शहद की मात्रा (kg)' : 'Honey Quantity (kg)'}
                      </label>
                      <input
                        id="harvest-quantity-input"
                        type="number"
                        min="0"
                        step="0.1"
                        className="form-input"
                        value={harvestQuantity}
                        onChange={(e) => setHarvestQuantity(e.target.value)}
                        style={{ height: '56px', fontSize: '1.05rem' }}
                        required
                      />
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

                    <div className="lab-information">

    <h3>Lab Verification</h3>

    <div className="lab-verification-grid">
      {/* Lab Name */}
      <div className="form-group lab-verification-field">
          <label>Lab Name</label>

          <input
              type="text"
              value={labName}
              onChange={(e) => {
                setLabName(e.target.value);
                setLabVerificationError('');
              }}
              placeholder="Enter laboratory name"
          />
      </div>

      {/* ULR Number */}
      <div className="form-group lab-verification-field">
          <label>ULR ID</label>

          <div className="ulr-input-row">
              <input
                  type="text"
                  value={ulrNumber}
                  onChange={(e) => {
                      setUlrNumber(e.target.value);
                      setUlrStatus(null);
                      setLabVerificationError('');
                  }}
                  placeholder="Enter ULR ID"
              />
              <button
                  type="button"
                  className="btn btn-secondary ulr-verify-btn"
                  onClick={handleVerifyULR}
              >
                  Verify
              </button>
          </div>
      </div>
    </div>

    {ulrStatus === "checking" && (
      <p className="ulr-status-message checking">Checking ULR ID...</p>
    )}

    {ulrStatus === "verified" && (
      <p className="ulr-status-message success">✓ ULR ID verified</p>
    )}

    {ulrStatus === "invalid" && (
      <p className="ulr-status-message error">✕ ULR ID not found</p>
    )}

    {labVerificationError && (
      <p className="ulr-status-message validation">⚠ {labVerificationError}</p>
    )}

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
                    <button className="btn btn-green btn-wizard-next" onClick={() => {
                      if (!labName.trim()) {
                        setLabVerificationError('Lab Name is required before continuing.');
                        return;
                      }

                      if (!ulrNumber.trim()) {
                        setLabVerificationError('ULR ID must be entered before continuing.');
                        return;
                      }

                      if (ulrStatus !== 'verified') {
                        setLabVerificationError('ULR ID must be verified before continuing.');
                        return;
                      }

                      setLabVerificationError('');
                      startVerificationProcess();
                    }}>
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
                        
                        <div className="qr-large-graphic" style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', padding: '1rem' }}>
                          {createdHarvestId && (() => {
                            const traceUrl = `${window.location.origin}/trace/${encodeURIComponent(createdHarvestId)}`;
                            return (
                              <QRCode
                                value={traceUrl}
                                size={180}
                                bgColor="#ffffff"
                                fgColor="#111827"
                                level="H"
                                includeMargin
                              />
                            );
                          })()}
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
  onClick={handleAddNewLocationBackend}
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

              {/* Visual History Timeline with Combined, Manual & IoT Views */}
              <div className="table-card" style={{ padding: '1.5rem', margin: 0 }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1rem', flexWrap: 'wrap', gap: '0.75rem' }}>
                  <div>
                    <h3 style={{ fontSize: '1.25rem', fontWeight: 800, margin: 0 }}>
                      {healthLogFilter === 'all'
                        ? (primaryLang === 'hi' ? 'समग्र गतिविधि समयरेखा (Combined Activity Timeline)' : 'Combined Activity Timeline')
                        : healthLogFilter === 'manual'
                          ? (primaryLang === 'hi' ? 'किसान निरीक्षण रिकॉर्ड (Manual Health Logs)' : 'Manual Health Logs')
                          : (primaryLang === 'hi' ? 'स्वचालित सेंसर लॉग (IoT Environmental Logs)' : 'IoT Environmental Logs')
                      }
                    </h3>
                    <span style={{ fontSize: '0.8rem', color: 'var(--color-text-light)' }}>
                      {healthLogFilter === 'all'
                        ? (primaryLang === 'hi' ? 'शारीरिक निरीक्षण एवं स्वचालित IoT सेंसर रीडिंग का संयुक्त दृश्य' : 'Unified stream of personal observations and automatic sensor readings')
                        : healthLogFilter === 'manual'
                          ? (primaryLang === 'hi' ? 'किसान द्वारा स्वयं दर्ज किए गए स्वास्थ्य व पेटी निरीक्षण' : 'Field observations recorded directly by the beekeeper')
                          : (primaryLang === 'hi' ? 'तापमान व नमी सेंसर द्वारा स्वतः दर्ज पर्यावरण रिकॉर्ड' : 'Telemetry recorded automatically from hive sensors')
                      }
                    </span>
                  </div>

                  {/* Filter Toggle */}
                  <div className="health-view-toggle-bar">
                    <button
                      type="button"
                      className={`health-view-btn ${healthLogFilter === 'all' ? 'active' : ''}`}
                      onClick={() => setHealthLogFilter('all')}
                    >
                      <Layers size={14} />
                      <span>{primaryLang === 'hi' ? 'संयुक्त दृश्य (All)' : 'All Activity'}</span>
                    </button>
                    <button
                      type="button"
                      className={`health-view-btn ${healthLogFilter === 'manual' ? 'active' : ''}`}
                      onClick={() => setHealthLogFilter('manual')}
                    >
                      🧑‍🌾 <span>{primaryLang === 'hi' ? 'किसान निरीक्षण (Manual)' : 'Manual Logs'}</span>
                    </button>
                    <button
                      type="button"
                      className={`health-view-btn ${healthLogFilter === 'iot' ? 'active' : ''}`}
                      onClick={() => setHealthLogFilter('iot')}
                    >
                      <Radio size={14} />
                      <span>{primaryLang === 'hi' ? 'IoT सेंसर (Automatic)' : 'IoT Telemetry'}</span>
                    </button>
                  </div>
                </div>
                
                {/* 1. IOT SPECIFIC TABLE VIEW */}
                {healthLogFilter === 'iot' ? (
                  <div className="table-responsive">
                    <table className="custom-table">
                      <thead>
                        <tr>
                          <th>{primaryLang === 'hi' ? 'समय / तारीख' : 'Time & Date'}</th>
                          <th>{primaryLang === 'hi' ? 'सेंसर आईडी' : 'Sensor ID'}</th>
                          <th>{primaryLang === 'hi' ? 'स्थान' : 'Apiary Site'}</th>
                          <th>{primaryLang === 'hi' ? 'तापमान' : 'Temperature'}</th>
                          <th>{primaryLang === 'hi' ? 'आर्द्रता' : 'Humidity'}</th>
                          <th>{primaryLang === 'hi' ? 'पर्यावरण स्थिति' : 'Environmental Status'}</th>
                        </tr>
                      </thead>
                      <tbody>
                        {iotReadings.map((reading, idx) => {
                          const ap = apiaries.find(a => a.locationId === (reading.locationId || reading.location_id));
                          const apName = ap?.name || `Apiary ${reading.locationId || reading.location_id}`;
                          const statusInfo = evaluateEnvironmentalStatus(reading.temperature, reading.humidity);
                          const dateObj = new Date(reading.timestamp);
                          const timeStr = dateObj.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
                          const dateStr = dateObj.toISOString().split('T')[0];

                          return (
                            <tr key={idx}>
                              <td>
                                <div><strong>{timeStr}</strong></div>
                                <span style={{ fontSize: '0.75rem', color: 'var(--color-text-light)' }}>{dateStr}</span>
                              </td>
                              <td>
                                <strong style={{ fontFamily: 'monospace', color: '#4338CA' }}>
                                  {reading.sensorId || reading.sensor_id}
                                </strong>
                              </td>
                              <td>{apName}</td>
                              <td>
                                <strong style={{ color: Number(reading.temperature) >= IOT_THRESHOLDS.temperature.min && Number(reading.temperature) <= IOT_THRESHOLDS.temperature.max ? 'var(--color-text-main)' : 'var(--color-warning)' }}>
                                  {Number(reading.temperature).toFixed(1)} °C
                                </strong>
                              </td>
                              <td>
                                <strong style={{ color: Number(reading.humidity) >= IOT_THRESHOLDS.humidity.min && Number(reading.humidity) <= IOT_THRESHOLDS.humidity.max ? 'var(--color-text-main)' : 'var(--color-warning)' }}>
                                  {Math.round(reading.humidity)}%
                                </strong>
                              </td>
                              <td>
                                <span className={`iot-status-pill ${!statusInfo.isWarning ? 'iot-status-normal' : 'iot-status-warning'}`}>
                                  {!statusInfo.isWarning
                                    ? (primaryLang === 'hi' ? '🟢 सामान्य' : 'Normal')
                                    : (primaryLang === 'hi' ? '🟡 चेतावनी' : 'Warning')}
                                </span>
                              </td>
                            </tr>
                          );
                        })}
                      </tbody>
                    </table>
                    <div style={{ marginTop: '0.75rem', fontSize: '0.78rem', color: 'var(--color-text-light)', textAlign: 'right' }}>
                      ℹ️ {primaryLang === 'hi' ? 'ये रिकॉर्ड सेंसर द्वारा स्वचालित रूप से एकत्रित किए जाते हैं।' : 'These records are automatically generated from sensor readings.'}
                    </div>
                  </div>
                ) : (
                  /* 2. COMBINED OR MANUAL LOG TIMELINE */
                  <div className="log-timeline">
                    {(() => {
                      // Normalize manual items
                      const manualTimelineItems = healthLogs.map(log => ({
                        type: 'manual',
                        key: `manual-${log.id}`,
                        timestamp: log.inspectionDate || log.date,
                        dateLabel: log.date,
                        title: log.apiaryName,
                        status: log.status,
                        statusHi: log.statusHi,
                        affectedColonies: log.affectedColonies,
                        notes: log.notes,
                        isAudio: log.audioNote
                      }));

                      // Normalize IoT items
                      const iotTimelineItems = iotReadings.map((reading, idx) => {
                        const ap = apiaries.find(a => a.locationId === (reading.locationId || reading.location_id));
                        const apName = ap?.name || `Apiary ${reading.locationId || reading.location_id}`;
                        const statusInfo = evaluateEnvironmentalStatus(reading.temperature, reading.humidity);
                        const dateObj = new Date(reading.timestamp);
                        const timeStr = dateObj.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
                        const dateStr = dateObj.toISOString().split('T')[0];

                        return {
                          type: 'iot',
                          key: `iot-${idx}`,
                          timestamp: reading.timestamp,
                          dateLabel: `${dateStr} • ${timeStr}`,
                          title: apName,
                          sensorId: reading.sensorId || reading.sensor_id,
                          temperature: reading.temperature,
                          humidity: reading.humidity,
                          status: statusInfo.status,
                          statusHi: statusInfo.statusHi,
                          isWarning: statusInfo.isWarning,
                          detail: statusInfo.detail,
                          notes: `Temperature ${Number(reading.temperature).toFixed(1)} °C, Humidity ${Math.round(reading.humidity)}% — ${statusInfo.status}`
                        };
                      });

                      const displayedItems = healthLogFilter === 'manual'
                        ? manualTimelineItems
                        : [...manualTimelineItems, ...iotTimelineItems].sort((a, b) => new Date(b.timestamp) - new Date(a.timestamp));

                      if (displayedItems.length === 0) {
                        return (
                          <div style={{ padding: '2rem', textAlign: 'center', color: 'var(--color-text-muted)' }}>
                            {primaryLang === 'hi' ? 'कोई रिकॉर्ड उपलब्ध नहीं है।' : 'No records found.'}
                          </div>
                        );
                      }

                      return displayedItems.map(item => {
                        if (item.type === 'manual') {
                          return (
                            <div key={item.key} className={`log-item ${
                              item.status === 'Healthy' ? 'status-healthy' : 
                              item.status === 'Needs Attention' ? 'status-needs-attention' : 'status-critical'
                            }`}>
                              <div className="log-meta">
                                <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                                  <span className="iot-source-badge badge-source-manual">
                                    🧑‍🌾 {primaryLang === 'hi' ? 'किसान निरीक्षण' : 'Manual Inspection'}
                                  </span>
                                  <strong style={{ color: 'var(--color-text-main)', fontSize: '0.95rem' }}>
                                    {item.title}
                                  </strong>
                                </div>
                                <span style={{ fontSize: '0.82rem', color: 'var(--color-text-light)' }}>{item.dateLabel}</span>
                              </div>

                              <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', margin: '0.35rem 0' }}>
                                <span className={`badge-active ${
                                  item.status === 'Healthy' ? 'status-healthy' : 'badge-expired'
                                }`} style={{
                                  backgroundColor: item.status === 'Healthy' ? '#DCFCE7' : '#FEF3C7',
                                  color: item.status === 'Healthy' ? '#15803D' : '#D97706',
                                  fontSize: '0.78rem'
                                }}>
                                  {item.status === 'Healthy' ? '🟢 Healthy / स्वस्थ' : '🟡 Needs Attention'}
                                </span>
                                {item.affectedColonies > 0 && (
                                  <span style={{ fontSize: '0.78rem', color: 'var(--color-danger)', fontWeight: 600 }}>
                                    ({item.affectedColonies} boxes)
                                  </span>
                                )}
                                {item.isAudio && (
                                  <span style={{ fontSize: '0.75rem', color: 'var(--color-secondary-dark)' }}>
                                    🎙️ Voice note
                                  </span>
                                )}
                              </div>

                              <p className="log-notes" style={{ margin: 0, fontSize: '0.88rem', color: 'var(--color-text-muted)' }}>
                                {item.notes}
                              </p>
                            </div>
                          );
                        }

                        // IoT Item
                        return (
                          <div key={item.key} className="log-item log-item-iot">
                            <div className="log-meta">
                              <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                                <span className="iot-source-badge badge-source-iot">
                                  📡 {primaryLang === 'hi' ? 'IoT सेंसर रीडिंग' : 'IoT Sensor Reading'}
                                </span>
                                <strong style={{ color: 'var(--color-text-main)', fontSize: '0.95rem' }}>
                                  {item.title}
                                </strong>
                                <span style={{ fontSize: '0.75rem', fontFamily: 'monospace', color: '#6366F1' }}>
                                  [{item.sensorId}]
                                </span>
                              </div>
                              <span style={{ fontSize: '0.82rem', color: 'var(--color-text-light)' }}>{item.dateLabel}</span>
                            </div>

                            <div style={{ display: 'flex', alignItems: 'center', gap: '0.6rem', margin: '0.35rem 0' }}>
                              <span className={`iot-status-pill ${!item.isWarning ? 'iot-status-normal' : 'iot-status-warning'}`}>
                                {!item.isWarning ? '🟢 Normal' : '🟡 Warning'}
                              </span>
                              <span style={{ fontSize: '0.85rem', fontWeight: 700, color: 'var(--color-text-main)' }}>
                                🌡️ {Number(item.temperature).toFixed(1)} °C
                              </span>
                              <span style={{ fontSize: '0.85rem', fontWeight: 700, color: 'var(--color-text-main)' }}>
                                💧 {Math.round(item.humidity)}%
                              </span>
                            </div>

                            <p className="log-notes" style={{ margin: 0, fontSize: '0.85rem', color: 'var(--color-text-muted)' }}>
                              {primaryLang === 'hi'
                                ? `स्वचालित टेलीमेट्री: तापमान ${Number(item.temperature).toFixed(1)} °C, नमी ${Math.round(item.humidity)}% — ${item.statusHi}`
                                : `Automatic telemetry: Temperature ${Number(item.temperature).toFixed(1)} °C, Humidity ${Math.round(item.humidity)}% — ${item.status}`
                              }
                            </p>
                          </div>
                        );
                      });
                    })()}
                  </div>
                )}
              </div>
            {/* ==========================================
    AI BEE DISEASE DETECTION
========================================== */}
<div
  className="form-card"
  style={{
    margin: 0,
    marginBottom: '24px',
    border: '1px solid #e5e7eb'
  }}
>
  <div style={{ marginBottom: '18px' }}>
    <h2
      style={{
        margin: 0,
        display: 'flex',
        alignItems: 'center',
        gap: '8px'
      }}
    >
      <Sparkles size={22} />
      AI Bee Disease Detection
    </h2>

    <p
      style={{
        margin: '6px 0 0',
        color: '#6b7280',
        fontSize: '14px'
      }}
    >
      Upload a clear image of a single bee to check for possible
      Varroa mite infection.
    </p>
  </div>

  {/* Image Upload */}
  <div
    style={{
      border: '2px dashed #d1d5db',
      borderRadius: '12px',
      padding: '24px',
      textAlign: 'center'
    }}
  >
    <Camera size={32} style={{ marginBottom: '8px' }} />

    <div style={{ marginBottom: '12px' }}>
      <strong>Select Bee Image</strong>

      <p
        style={{
          margin: '5px 0 0',
          color: '#6b7280',
          fontSize: '13px'
        }}
      >
        JPG, PNG or WEBP • Maximum 10 MB
      </p>
    </div>

    <input
      type="file"
      accept="image/jpeg,image/png,image/jpg,image/webp"
      onChange={handleAiImageChange}
    />
  </div>

  {/* Image Preview */}
  {aiPreview && (
    <div style={{ marginTop: '18px', textAlign: 'center' }}>
      <img
        src={aiPreview}
        alt="Selected bee"
        style={{
          maxWidth: '100%',
          maxHeight: '280px',
          borderRadius: '12px',
          objectFit: 'contain',
          border: '1px solid #e5e7eb'
        }}
      />
    </div>
  )}

  {/* Analyze Button */}
  {aiImage && (
    <button
      type="button"
      onClick={handleAiPrediction}
      disabled={aiLoading}
      className="primary-btn"
      style={{
        marginTop: '16px',
        width: '100%'
      }}
    >
      <Sparkles size={18} />

      {aiLoading
        ? 'Analyzing Image...'
        : 'Analyze Bee with AI'}
    </button>
  )}

  {/* Error */}
  {aiError && (
    <div
      style={{
        marginTop: '16px',
        padding: '12px',
        borderRadius: '8px',
        background: '#fef2f2',
        color: '#b91c1c',
        fontSize: '14px'
      }}
    >
      {aiError}
    </div>
  )}

  {/* AI Result */}
  {aiResult && (
    <div
      style={{
        marginTop: '20px',
        padding: '18px',
        borderRadius: '12px',
        background: '#f9fafb',
        border: '1px solid #e5e7eb'
      }}
    >
      <h3 style={{ marginTop: 0 }}>
        AI Analysis Result
      </h3>

      <div
        style={{
          fontSize: '20px',
          fontWeight: 700,
          marginBottom: '8px'
        }}
      >
        {aiResult.prediction}
      </div>

      <div style={{ color: '#6b7280' }}>
        Varroa probability:{' '}
        {(aiResult.varroaProbability * 100).toFixed(2)}%
      </div>

      <div style={{ color: '#6b7280', marginTop: '4px' }}>
        Confidence: {aiResult.confidence.toFixed(2)}%
      </div>

      {aiResult.prediction === 'Possible Varroa' && (
        <div
          style={{
            marginTop: '14px',
            padding: '12px',
            borderRadius: '8px',
            background: '#fef2f2',
            color: '#b91c1c',
            fontSize: '14px'
          }}
        >
          ⚠️ Possible Varroa detected. Further hive inspection
          is recommended.
        </div>
      )}

      {aiResult.prediction === 'Healthy' && (
        <div
          style={{
            marginTop: '14px',
            padding: '12px',
            borderRadius: '8px',
            background: '#f0fdf4',
            color: '#166534',
            fontSize: '14px'
          }}
        >
          ✓ No Varroa indication detected in this image.
        </div>
      )}

      {aiResult.prediction === 'Needs Inspection' && (
        <div
          style={{
            marginTop: '14px',
            padding: '12px',
            borderRadius: '8px',
            background: '#fffbeb',
            color: '#92400e',
            fontSize: '14px'
          }}
        >
          ⚠️ The result is uncertain. Manual inspection is
          recommended.
        </div>
      )}
    </div>
  )}
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

              <button
                type="button"
                className="btn btn-outline-green"
                onClick={handleUseCurrentLocationForMove}
                style={{ width: '100%', marginBottom: '0.75rem', minHeight: '44px' }}
              >
                {primaryLang === 'hi' ? '📍 वर्तमान स्थान का उपयोग करें' : '📍 Use Current Location'}
              </button>

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
