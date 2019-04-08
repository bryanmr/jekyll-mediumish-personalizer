/* exported fetchComments */
'use strict';

/** Fetches Reddit comment thread and then writes it to console
 * @param {string} siteURL - URL of the post we are checking for */
exports.fetchComments = () => {
  const siteURL = process.env.site_url;
  const bucketName = process.env.bucket_short_name;
  const bucketDir = process.env.bucket_dir;
  const {Storage} = require('@google-cloud/storage');
  const storage = new Storage();
  const myBucket = storage.bucket(bucketName);
  const file = myBucket.file(bucketDir+'/reddit_comment_threads.json');

  const https = require('https');

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
      file.save(rawData).then(function() {
        console.log('Saved to file!');
      }).catch(function(e) {
        console.error('We failed at saving! Got: '+e.message);
      });
    });
  }).on('error', (e) => {
    console.error(`Got error: ${e.message}`);
  });
};
