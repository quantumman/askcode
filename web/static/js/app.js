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
import Lazy from 'lazy.js';

import 'bootstrap/dist/css/bootstrap.css';
import '../../static/css/app.css';


const elmDiv = document.getElementById("elm-main")
    , elmApp = Elm.Main.embed(elmDiv);

const flatten = nodeList => {
  if (!nodeList) {
    return [];
  }

  const nodes = Lazy(Array.from(nodeList));
  const childNodes = nodes
    .filter(node => typeof node.childNodes !== 'undefined')
    .map(node => flatten(node.childNodes).toArray())
    .flatten();
  return nodes.concat(childNodes);
};

const observe = (id, selector, callback) => {
  const observer = new MutationObserver((mutations, self) => {
    const found = Lazy(mutations)
      .map(mutation => flatten(selector(mutation)))
      .flatten()
      .filter(node => typeof node.attributes !== 'undefined')
      .filter(node => node.attributes.getNamedItem('id') !== null)
      .map(node => node.attributes.getNamedItem('id').value)
      .find(x => x === id);
    callback(found, self);
  });

  observer.observe(elmDiv, {
    childList: true,
    subtree: true,
  });

  return observer;
};

const observeOn = id => {
  const observeDomRemoved = targetId =>
    observe(targetId, m => m.removedNodes, (removedId, self) => {
      if (removedId) {
        elmApp.ports.removeDom.send(removedId);
        self.disconnect();
      }
    });

  const sendDomAdded = target => {
    if (target) {
      const id = target.id || target;
      setTimeout(() => elmApp.ports.addDom.send(id), 0);
      observeDomRemoved(id);
    }
  };

  const element = document.getElementById(id);
  if (element) {
    sendDomAdded(element);
    return undefined;
  }
  else {
    return observe(id, m => m.addedNodes, addedId => {
      sendDomAdded(addedId);
    });
  }
};


// Ace editor
const editor = {};
const initialize = (element, text) => {
  const id = element.id;
  if (!editor[id]) {
    editor[id] = Ace.edit(element);
    editor[id].setValue(text);
    editor[id].on('change', e => {
      elmApp.ports.change.send([id, editor[id].getValue()]);
    });
  }
};
elmApp.ports.initialize.subscribe(([id, text]) => {
  var target = document.getElementById(id);
  if (target) {
    initialize(target, text);
  }
});
elmApp.ports.destroy.subscribe(id => {
  if (editor[id]) {
    editor[id].destroy();
    delete editor[id];
  }
});


const observers = {};
elmApp.ports.observe.subscribe(id => {
  observers[id] = observeOn(id);
});
elmApp.ports.disconnect.subscribe(id => {
  if (observers[id]) {
    observers[id].disconnect(id);
    delete observers[id];
  }
});





// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
