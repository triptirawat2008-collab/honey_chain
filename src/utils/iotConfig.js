// HoneyChain IoT Environmental Monitoring Configuration
// Rule-based thresholds for Temperature and Humidity inside/near apiary hives.
// Note: These measure environmental conditions, not guaranteed biological colony health.

export const IOT_THRESHOLDS = {
  temperature: {
    min: 30.0,
    max: 36.0,
    unit: '°C',
    warningLowLabel: 'Low Temperature (<30°C)',
    warningHighLabel: 'High Temperature (>36°C)'
  },
  humidity: {
    min: 50.0,
    max: 70.0,
    unit: '%',
    warningLowLabel: 'Low Humidity (<50%)',
    warningHighLabel: 'High Humidity (>70%)'
  }
};

/**
 * Internal mapping of Apiary Location IDs to assigned IoT Sensors.
 * Hardware devices (e.g. Arduino / ESP32) will report their assigned sensorId.
 */
export const LOCATION_SENSOR_MAP = {
  'LOC-001': {
    sensorId: 'TEMP-HUM-001',
    model: 'DHT22 / SHT31 Agricultural Sensor',
    apiaryName: 'Apiary 1 - Rampur Mustard Belt',
    installedAt: '2026-08-15'
  },
  'LOC-002': {
    sensorId: 'TEMP-HUM-002',
    model: 'DHT22 / SHT31 Agricultural Sensor',
    apiaryName: 'Apiary 2 - Moradabad Hills Farm',
    installedAt: '2026-08-18'
  }
};

export function getSensorForLocation(locationId) {
  if (LOCATION_SENSOR_MAP[locationId]) {
    return LOCATION_SENSOR_MAP[locationId];
  }
  const idNum = locationId ? String(locationId).replace(/\D/g, '') : '1';
  return {
    sensorId: 'TEMP-HUM-' + idNum.padStart(3, '0'),
    model: 'DHT22 Standard Hive Sensor',
    apiaryName: 'Apiary ' + (locationId || 'Site'),
    installedAt: '2026-08-20'
  };
}

/**
 * Simple rule-based checking for environmental conditions.
 * Compares sensor readings against configured ranges.
 */
export function evaluateEnvironmentalStatus(temperature, humidity) {
  const tempNum = Number(temperature);
  const humNum = Number(humidity);

  const isTempNormal = tempNum >= IOT_THRESHOLDS.temperature.min && tempNum <= IOT_THRESHOLDS.temperature.max;
  const isHumNormal = humNum >= IOT_THRESHOLDS.humidity.min && humNum <= IOT_THRESHOLDS.humidity.max;

  if (isTempNormal && isHumNormal) {
    return {
      status: 'Normal',
      statusHi: 'सामान्य (अनुकूल वातावरण)',
      isWarning: false,
      detail: 'Brood nest temperature & humidity within optimal range'
    };
  }

  const warnings = [];
  if (tempNum < IOT_THRESHOLDS.temperature.min) warnings.push('Cold/Low Temp');
  if (tempNum > IOT_THRESHOLDS.temperature.max) warnings.push('Heat/High Temp');
  if (humNum < IOT_THRESHOLDS.humidity.min) warnings.push('Dry Air');
  if (humNum > IOT_THRESHOLDS.humidity.max) warnings.push('High Moisture');

  return {
    status: 'Warning',
    statusHi: 'सावधानी (वातावरण असंतुलित)',
    isWarning: true,
    detail: warnings.join(', ')
  };
}
