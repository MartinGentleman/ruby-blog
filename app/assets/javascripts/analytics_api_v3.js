//var accountID = "2279700"; // Web Help Desk http://www.webhelpdesk.com
//var trackingID = "UA-2279700-2"; // webhelpdesk.com 
var view = "4306548";
//var tableID = "ga:4306548";

function makeApiCall() {
  queryCoreReportingApi(view);
}

function queryCoreReportingApi(profileId) {
  console.log('Querying Core Reporting API.');

  // Use the Analytics Service Object to query the Core Reporting API
  /*gapi.client.analytics.data.ga.get({
    'ids': 'ga:' + profileId,
    'start-date': '2012-03-03',
    'end-date': '2012-03-03',
    'metrics': 'ga:sessions'
    //'metrics': 'rt:activeUsers'
  }).execute(handleCoreReportingResults);*/
  gapi.client.analytics.data.realtime.get({
    'ids': 'ga:' + profileId,
    'start-date': '2012-03-03',
    'end-date': '2012-03-03',
    //'metrics': 'ga:sessions'
    'metrics': 'rt:activeUsers'
  }).execute(handleCoreReportingResults);
}

function handleCoreReportingResults(results) {
  if (results.error) {
    console.log('There was an error querying core reporting API: ' + results.message);
  } else {
    printResults(results);
  }
}

function printResults(results) {
  if (results.rows && results.rows.length) {
    console.log('View (Profile) Name: ', results.profileInfo.profileName);
    console.log('Total Sessions: ', results.rows[0][0]);
  } else {
    console.log('No results found');
  }
}