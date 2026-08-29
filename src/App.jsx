import { useState } from 'react';
import LandingPage from './pages/LandingPage';
import RoleSelection from './pages/RoleSelection';
import BeekeeperRegistration from './pages/BeekeeperRegistration';
import CompanyRegistration from './pages/CompanyRegistration';
import BeekeeperDashboard from './pages/BeekeeperDashboard';
import CompanyDashboard from './pages/CompanyDashboard';
import ConsumerTraceability from './pages/ConsumerTraceability';
import TopDemoBar from './components/TopDemoBar';

import {
  INITIAL_HARVESTS,
  INITIAL_BATCHES,
  INITIAL_APIARIES,
  INITIAL_HEALTH_LOGS,
  INITIAL_REMINDERS,
  INITIAL_HISTORY
} from './data/mockData';

function App() {
  const [view, setView] = useState('landing'); // landing, role-selection, beekeeper-verify, company-verify, beekeeper-dash, company-dash, consumer-trace
  
  // Dual Language State: 'hi' (Hindi Primary) or 'en' (English Primary)
  const [primaryLang, setPrimaryLang] = useState('hi');

  // Low Connectivity / 2G Offline Simulation State
  const [isOffline, setIsOffline] = useState(false);

  // Authenticated/Verified Users
  const [beekeeperUser, setBeekeeperUser] = useState(null);
  const [companyUser, setCompanyUser] = useState(null);

  // Active lookup tracking ID for the consumer view
  const [activeTraceId, setActiveTraceId] = useState('BT-LIC001-20260825-01');

  // Core State lists initialized with mock data
  const [harvests, setHarvests] = useState(INITIAL_HARVESTS);
  const [batches, setBatches] = useState(INITIAL_BATCHES);
  const [apiaries, setApiaries] = useState(INITIAL_APIARIES);
  const [healthLogs, setHealthLogs] = useState(INITIAL_HEALTH_LOGS);
  const [reminders, setReminders] = useState(INITIAL_REMINDERS);
  const [history, setHistory] = useState(INITIAL_HISTORY);

  return (
    <div className="honey-app-wrapper">
      {/* Top Persistent SIH Demo Navigation Bar */}
      <TopDemoBar
        isOffline={isOffline}
        setIsOffline={setIsOffline}
        primaryLang={primaryLang}
        setPrimaryLang={setPrimaryLang}
      />

      {/* State-based Navigation Router */}
      {view === 'landing' && (
        <LandingPage 
          setView={setView} 
          setActiveTraceId={setActiveTraceId}
          primaryLang={primaryLang}
        />
      )}

      {view === 'role-selection' && (
        <RoleSelection 
          setView={setView}
          primaryLang={primaryLang}
        />
      )}

      {view === 'beekeeper-verify' && (
        <BeekeeperRegistration 
          setView={setView} 
          setBeekeeperUser={setBeekeeperUser}
          primaryLang={primaryLang}
        />
      )}

      {view === 'company-verify' && (
        <CompanyRegistration 
          setView={setView} 
          setCompanyUser={setCompanyUser}
          primaryLang={primaryLang}
        />
      )}

      {view === 'beekeeper-dash' && beekeeperUser && (
        <BeekeeperDashboard
          user={beekeeperUser}
          setView={setView}
          harvests={harvests}
          setHarvests={setHarvests}
          apiaries={apiaries}
          setApiaries={setApiaries}
          healthLogs={healthLogs}
          setHealthLogs={setHealthLogs}
          reminders={reminders}
          setReminders={setReminders}
          history={history}
          setHistory={setHistory}
          setActiveTraceId={setActiveTraceId}
          primaryLang={primaryLang}
          isOffline={isOffline}
        />
      )}

      {view === 'company-dash' && companyUser && (
        <CompanyDashboard
          user={companyUser}
          setView={setView}
          harvests={harvests}
          batches={batches}
          setBatches={setBatches}
          history={history}
          setHistory={setHistory}
          setActiveTraceId={setActiveTraceId}
          primaryLang={primaryLang}
        />
      )}

      {view === 'consumer-trace' && (
        <ConsumerTraceability
          traceId={activeTraceId}
          setActiveTraceId={setActiveTraceId}
          setView={setView}
          harvests={harvests}
          batches={batches}
          primaryLang={primaryLang}
        />
      )}
    </div>
  );
}

export default App;
