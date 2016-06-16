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

const callWhenIdAdded = (parent, id, fun) => {
  const observer = new MutationObserver((mutations) => {
    // Get an array of the added ids
    const addedIds = mutations.reduce((acc, mutationRecord) => {
      const ids = Array
        .from(mutationRecord.addedNodes)
        .filter(node => node.attributes.getNamedItem('id') !== null)
        .map(node => node.attributes.getNamedItem('id').value);

      return acc.concat(ids);
    }, []);

    // If that contains the id we are looking for then invoke the function and remove the observer
    if (addedIds.indexOf(id) >= 0) {
      observer.disconnect();
      fun();
    }
  })

  observer.observe(parent, {
    childList: true,
    subtree: true
  });
};


callWhenIdAdded(
  elmDiv, 'elm-main-app', () => {
    elmApp.ports.ready.send('ready');
  }
);

// initialize
const editor = {};
elmApp.ports.initialize.subscribe(([id, text]) => {
  if (editor[id] === undefined) {
    editor[id] = Ace.edit(id);

    editor[id].setValue(text);
    editor[id].on('change', e => {
      elmApp.ports.change.send(editor[id].getValue());
    });
  }
});

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
