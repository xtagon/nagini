import Component from '@ember/component';
import { computed } from '@ember/object';
import { or } from '@ember/object/computed';
import { isPresent } from '@ember/utils';

// This needs to match the fixed size of the canvas element (width and height
// should be the same)
const canvasSize = 400;

const defaultWidth = 11;
const defaultHeight = 11;

const config = {
  radius: 30,
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
  onHoverCell: null,

  points: computed("world", function() {
    const world = this.get("world");
    if (!world) return [];

    const points = world.board.snakes.flatMap(({body}) => {
      return body.map(({x, y}) => {
        return {x, y, value: 1.0};
      });
    });

    return points;
  }),

  heatmapPoints: computed("points", "width", "height", function() {
    const width = this.get("width");
    const height = this.get("height");

    let points = this.get("points") || [];

    points = points.map(({x, y, value}) => {
      x = (x + 0.5) / width * canvasSize;
      y = (y + 0.5) / height * canvasSize;
      return {x, y, value};
    });

    return points;
  }),

  actions: {
    setFocusedPoint(x, y) {
      const onHoverCell = this.get("onHoverCell");

      if (isPresent(x) && isPresent(y) && onHoverCell) {
        const points = this.get("points");
        const focusedPoint = points.find(point => point.x === x && point.y === y);

        if (focusedPoint) {
          onHoverCell(focusedPoint);
        } else {
          onHoverCell({x, y, value: 0});
        }
      }
    }
  }
});
