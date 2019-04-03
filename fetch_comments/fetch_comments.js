const https = require('https');
const siteURL = process.env.site_url;

https.get('https://www.reddit.com/search.json?q=site%3A"'+
  siteURL+'"', (res) => {
  const {statusCode} = res;
  const contentType = res.headers['content-type'];
  let error;

  if (statusCode !== 200) {
    error = new Error('Request Failed.\n'+
                      `Status Code: ${statusCode}`);
  } else if (!/^application\/json/.test(contentType)) {
    error = new Error('Invalid content-type.\n'+
                      `Expected application/json but received ${contentType}`);
  }

  if (error) {
    console.error(error.message);
    return;
  }

  let rawData = '';

  res.setEncoding('utf8');

  res.on('data', (chunk) => {
    rawData += chunk;
  });

  res.on('end', () => {
    try {
      console.log(rawData);
    } catch (e) {
      console.error(e.message);
    }
  });
}).on('error', (e) => {
  console.error(`Got error: ${e.message}`);
});
