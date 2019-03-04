import Component from '@ember/component';
import { computed } from '@ember/object';
import { or } from '@ember/object/computed';

// This needs to match the fixed size of the canvas element (width and height
// should be the same)
const canvasSize = 400;

const defaultWidth = 11;
const defaultHeight = 11;

const config = {
  radius: 40,
  minOpacity: 0,
  maxOpacity: 1,
  blur: .75
};

export default Component.extend({
  classNames: "board-heatmap",

  config,
  world: null,
  width: or("world.board.width", "defaultWidth"),
  height: or("world.board.height", "defaultHeight"),
  defaultWidth,
  defaultHeight,

  data: computed("world", function() {
    const world = this.get("world");
    if (!world) return [];

    const points = world.board.snakes.flatMap(({body}) => {
      return body.map(({x, y}) => {
        x = (x + 0.5) / world.board.width * canvasSize;
        y = (y + 0.5) / world.board.height * canvasSize;
        return {x, y, value: 1.0};
      });
    });

    return points;
  }),
});
