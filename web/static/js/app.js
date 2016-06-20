// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html";
import Elm from "../../static/elm/Main.elm";
import Ace from 'brace';

import 'bootstrap/dist/css/bootstrap.css';
import '../../static/css/app.css';

const elmDiv = document.getElementById("elm-main")
    , elmApp = Elm.Main.embed(elmDiv);

const onNodeMutated = (id, parent, selector, callback) => {
  const observer = new MutationObserver(mutations => {
    const mutatedIds = mutations.reduce((acc, mutationRecord) => {
      const ids = Array
        .from(selector(mutationRecord))
        .filter(node => node.attributes.getNamedItem('id') !== null)
        .map(node => node.attributes.getNamedItem('id').value);
      return acc.concat(ids);
    }, []);

    if (mutatedIds.indexOf(id) >= 0) {
      observer.disconnect();
      callback(mutatedIds);
    }
  });

  observer.observe(parent, {
    childList: true,
    subtree: true
  });
};

onNodeMutated('elm-main-app', elmDiv, m => m.addedNodes, ids => {
  elmApp.ports.ready.send('ready');
});

const editor = {};
elmApp.ports.initialize.subscribe(([id, text]) => {
  if (id && editor[id] === undefined) {
    editor[id] = Ace.edit(id);

    editor[id].setValue(text);
    editor[id].on('change', e => {
      elmApp.ports.change.send([id, editor[id].getValue()]);
    });

    onNodeMutated(id, elmDiv, m => m.removedNodes, ids => {
      if (editor[id]) {
        editor[id].destroy();
        delete editor[id];
      }
    });
  }
});

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
