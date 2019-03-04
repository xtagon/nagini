import Controller from '@ember/controller';
import { computed } from '@ember/object';
import { or, equal } from '@ember/object/computed';

const exampleWorld = {"board":{"food":[{"x":8,"y":7},{"x":3,"y":1},{"x":10,"y":5},{"x":5,"y":4},{"x":8,"y":0},{"x":4,"y":1}],"height":11,"snakes":[{"body":[{"x":1,"y":1},{"x":1,"y":1},{"x":1,"y":1}],"health":100,"id":"gs_dTGHX4BtPC4QXfdW9wyH9BrX","name":"Zullybur / Inclusivity Snek"},{"body":[{"x":9,"y":9},{"x":9,"y":9},{"x":9,"y":9}],"health":100,"id":"gs_vmRbJxCQFbtX8wxY6TykRpD7","name":"mvliet / David Hasslesnake"},{"body":[{"x":1,"y":9},{"x":1,"y":9},{"x":1,"y":9}],"health":100,"id":"gs_4r8xXcrQhtWkDCG8p4Rp7T4W","name":"danielberndt / naive"},{"body":[{"x":9,"y":1},{"x":9,"y":1},{"x":9,"y":1}],"health":100,"id":"gs_6YxX6pTfBcrqCTPBpJTTWq9G","name":"buhikon / Flatwhite"},{"body":[{"x":5,"y":1},{"x":5,"y":1},{"x":5,"y":1}],"health":100,"id":"gs_yTRD6xkbW3MRqH7MYgcTqQ4C","name":"xtagon / Nagini"},{"body":[{"x":9,"y":5},{"x":9,"y":5},{"x":9,"y":5}],"health":100,"id":"gs_GXFybk7yqfRtRCb7xSFS4BB4","name":"MikeShi42 / Boba Apprentice"}],"width":11},"game":{"id":"0cea5d0c-a5bb-4af4-a560-0efc80932867"},"turn":0,"you":{"body":[{"x":5,"y":1},{"x":5,"y":1},{"x":5,"y":1}],"health":100,"id":"gs_yTRD6xkbW3MRqH7MYgcTqQ4C","name":"xtagon / Nagini"}};

export default Controller.extend({
  exampleWorld,
  world: or("parsedWorld", "exampleWorld"),
  worldJson: null,

  parsedWorld: computed("worldJson", function() {
    const json = this.get("worldJson");
    if (!json) return;

    let world;

    try {
      world = JSON.parse(json);
    } catch(e) {
      world = false;
    }

    return world;
  }),

  invalidWorldJson: equal("parsedWorld", false)
});
