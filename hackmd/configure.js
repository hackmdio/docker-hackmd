var fs = require('fs');

var config = JSON.parse(fs.readFileSync('config.json', 'utf8'));;

config.production;
if (process.env.DOMAIN)
    config.production.domain=process.env.DOMAIN;

if (process.env.URLPATH)
    config.production.urlpath=process.env.URLPATH;

if (process.env.PROTOCOLUSESSL)
    config.production.protocolusessl=string2Boolean(process.env.PROTOCOLUSESSL);

if (process.env.URLADDPORT)
    config.production.urladdport=string2Boolean(process.env.URLADDPORT);

if (process.env.USECDN)
    config.production.usecdn=string2Boolean(process.env.USECDN);

if (process.env.GITHUB_CLIENTID && process.env.GITHUB_CLIENTSECRET) {
	config.production.github = {
        clientID: process.env.GITHUB_CLIENTID,
        clientSecret: process.env.GITHUB_CLIENTSECRET
    };
}

if (process.env.TWITTER_CLIENTID && process.env.TWITTER_CLIENTSECRET) {
    config.production.twitter = {
        consumerKey: process.env.TWITTER_CLIENTID,
        consumerSecret: process.env.TWITTER_CLIENTSECRET
    };
}

if (process.env.FACEBOOK_CLIENTID && process.env.FACEBOOK_CLIENTSECRET) {
    config.production.facebook = {
        consumerKey: process.env.FACEBOOK_CLIENTID,
        consumerSecret: process.env.FACEBOOK_CLIENTSECRET
    };
}

if (process.env.GITLAB_CLIENTID && process.env.GITLAB_BASEURL && process.env.GITLAB_CLIENTSECRET) {
    config.production.gitlab = {
	    baseURL: process.env.GITLAB_BASEURL,
        consumerKey: process.env.GITLAB_CLIENTID,
        consumerSecret: process.env.GITLAB_CLIENTSECRET
    };
}

jsonString = JSON.stringify(config);

fs.writeFile("config.json", JSON.stringify(config), function(err) {
    if(err) {
        console.log(err);
    } else {
        console.log("Config file updated");
    }
});


function string2Boolean(variable) {
    return (variable === "1" || variable == "true");
}
