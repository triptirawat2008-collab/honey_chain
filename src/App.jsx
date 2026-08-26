import { useState } from 'react';
import LandingPage from './pages/LandingPage';
import RoleSelection from './pages/RoleSelection';
import BeekeeperRegistration from './pages/BeekeeperRegistration';
import CompanyRegistration from './pages/CompanyRegistration';
import BeekeeperDashboard from './pages/BeekeeperDashboard';
import CompanyDashboard from './pages/CompanyDashboard';
import ConsumerTraceability from './pages/ConsumerTraceability';

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
  
  // Authenticated/Verified Users
  const [beekeeperUser, setBeekeeperUser] = useState(null);
  const [companyUser, setCompanyUser] = useState(null);

  // Active lookup tracking ID for the consumer view
  const [activeTraceId, setActiveTraceId] = useState(null);

  // Core State lists initialized with mock data
  const [harvests, setHarvests] = useState(INITIAL_HARVESTS);
  const [batches, setBatches] = useState(INITIAL_BATCHES);
  const [apiaries, setApiaries] = useState(INITIAL_APIARIES);
  const [healthLogs, setHealthLogs] = useState(INITIAL_HEALTH_LOGS);
  const [reminders, setReminders] = useState(INITIAL_REMINDERS);
  const [history, setHistory] = useState(INITIAL_HISTORY);

  return (
    <>
      {/* State-based Navigation Router */}
      {view === 'landing' && (
        <LandingPage 
          setView={setView} 
          setActiveTraceId={setActiveTraceId} 
        />
      )}

      {view === 'role-selection' && (
        <RoleSelection 
          setView={setView} 
        />
      )}

      {view === 'beekeeper-verify' && (
        <BeekeeperRegistration 
          setView={setView} 
          setBeekeeperUser={setBeekeeperUser} 
        />
      )}

      {view === 'company-verify' && (
        <CompanyRegistration 
          setView={setView} 
          setCompanyUser={setCompanyUser} 
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
        />
      )}

      {view === 'consumer-trace' && (
        <ConsumerTraceability
          traceId={activeTraceId}
          setView={setView}
          harvests={harvests}
          batches={batches}
        />
      )}
    </>
  );
}

export default App;
