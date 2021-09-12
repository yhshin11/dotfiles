// My settings
settings.scrollStepSize = 140;
const searchleader = 's'; // Type <s+ALIAS> to search selected
const googleleader = '\`'; // Type <`+ALIAS> to open search box

// Helper function to make google search url
function GoogleSearchUrl () {
    var url = 'https://www.google.com/search?q=';
    for (var i = 0; i < arguments.length; i++) {
        url += arguments[i];
        url += '+'; 
    }
    return url;
}
function GoogleSuggestionUrl() {
    var url = 'https://www.google.com/complete/search?client=chrome-omni&gs_ri=chrome-ext&oit=1&cp=1&pgcl=7&q=';
    for (var i = 0; i < arguments.length; i++) {
        url += arguments[i];
        url += '+'; 
    }
    return url;
}
function GoogleSuggestionCallback(response) {
    var res = JSON.parse(response.text);
    return res[1];
}

function AddGoogleAlias(s) {
    // addSearchAliasX(s.alias, s.name, GoogleSearchUrl(s.search), searchleader);
    addSearchAliasX(s.alias, s.name, GoogleSearchUrl(s.search), searchleader, GoogleSuggestionUrl(s.search), GoogleSuggestionCallback);
    mapkey(`${googleleader}${s.alias}`, `#8Search ${s.name}`, () => Front.openOmnibar({ type: "SearchEngine", extra: s.alias }));
}

aliases = [
  { name: 'numpy', alias: 'np', search: 'numpy', },
  { name: 'pytorch', alias: 'pt', search: 'pytorch', },
  { name: 'torchvision', alias: 'tv', search: 'torchvision', },
  { name: 'pytorch lightning', alias: 'pl', search: 'pytorch+lightning', },
  { name: 'tensorflow', alias: 'tf', search: 'tensorflow', },
  { name: 'matplotlib', alias: 'mp', search: 'matplotlib', },
  { name: 'sklearn', alias: 'sk', search: 'sklearn', },
  { name: 'seaborn', alias: 'sn', search: 'seaborn', },
];

for (var s in aliases) {
  AddGoogleAlias(aliases[s]);
}

// Syntax for adding aliases
// addSearchAlias(alias, prompt, search_url, suggestion_url, callback_to_parse_suggestion);
// addSearchAliasX(alias, prompt, search_url, search_leader_key, suggestion_url, callback_to_parse_suggestion, only_this_site_key);
// addSearchAliasX('pt', 'pytorch', GoogleSearchUrl('pytorch'), 's', GoogleSuggestionUrl(), GoogleSuggestionCallback);
// addSearchAliasX('pl', 'pytorch lightning', GoogleSearchUrl('pytorch+lightning'), 's', GoogleSuggestionUrl(), function(response) {
//     var res = JSON.parse(response.text);
//     return res[1];
// });
// addSearchAliasX('mp', 'matplotlib', GoogleSearchUrl('matplotlib'), 's', GoogleSuggestionUrl(), function(response) {
//     var res = JSON.parse(response.text);
//     return res[1];
// });

// // an example to create a new mapping `ctrl-y`
// mapkey('<ctrl-y>', 'Show me the money', function() {
//     Front.showPopup('a well-known phrase uttered by characters in the 1996 film Jerry Maguire (Escape to close).');
// });

// // an example to replace `T` with `gt`, click `Default mappings` to see how `T` works.
// map('gt', 'T');

// // an example to remove mapkey `Ctrl-i`
// unmap('<ctrl-i>');

// set theme
settings.theme = `
.sk_theme {
    font-family: Input Sans Condensed, Charcoal, sans-serif;
    font-size: 10pt;
    background: #24272e;
    color: #abb2bf;
}
.sk_theme tbody {
    color: #fff;
}
.sk_theme input {
    color: #d0d0d0;
}
.sk_theme .url {
    color: #61afef;
}
.sk_theme .annotation {
    color: #56b6c2;
}
.sk_theme .omnibar_highlight {
    color: #528bff;
}
.sk_theme .omnibar_timestamp {
    color: #e5c07b;
}
.sk_theme .omnibar_visitcount {
    color: #98c379;
}
.sk_theme #sk_omnibarSearchResult ul li:nth-child(odd) {
    background: #303030;
}
.sk_theme #sk_omnibarSearchResult ul li.focused {
    background: #3e4452;
}
#sk_status, #sk_find {
    font-size: 20pt;
}`;
// click `Save` button to make above settings to take effect.</ctrl-i></ctrl-y>
