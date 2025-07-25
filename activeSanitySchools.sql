SELECT
  TRIM(KegName) AS schoolName,
  khs.Country,
  c.Iso,
  khs.Website
FROM `keystone-ssgtm.data_from_keystone_core.KegEntity` AS ke
LEFT JOIN `keystone-ssgtm.data_from_keystone_core.KegSmartHubMapping` AS kshm ON ke.KegId = kshm.KegId
LEFT JOIN `keystone-ssgtm.data_from_keystone_core.SmartHubProfile` AS shp ON kshm.SmartHubId = shp.SmartHubId
LEFT JOIN `keystone-ssgtm.data_from_keystone_core.KegKasHubSpotMapping` AS kkhsm ON ke.KegId = kkhsm.KegId
LEFT JOIN `keystone-ssgtm.data_from_keystone_core.KasHubSpot` AS khs ON kkhsm.HubSpotId = khs.HubSpotId
LEFT JOIN `keystone-ssgtm.data_from_keystone_core.Countries` AS c ON khs.Country = c.NiceName
WHERE shp.Active IS TRUE
AND shp.Published IS TRUE
GROUP BY 1,2,3,4