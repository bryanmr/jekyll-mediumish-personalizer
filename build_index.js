var lunr = require('lunr'),
    stdin = process.stdin,
    stdout = process.stdout,
    buffer = [];

stdin.resume();
stdin.setEncoding('utf8');

stdin.on('data', function (data) {
  buffer.push(data);
});

stdin.on('end', function () {
  var documents = JSON.parse(buffer.join(''));

  var idx = lunr(function () {
    this.field('title', { boost: 5 });
    this.field('content');
    this.ref('url');
    this.field('author');
    this.field('categories', { boost: 5 });
    this.field('tags', { boost: 10 });


    documents.forEach(function (doc) {
      this.add(doc);
    }, this);
  });

  stdout.write(JSON.stringify(idx));
});
