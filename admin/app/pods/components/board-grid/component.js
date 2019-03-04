import Component from '@ember/component';

export default Component.extend({
  classNames: ["board-grid", "grid"],

  onHoverCell: null,

  actions: {
    hoverCell(x, y) {
      const onHoverCell = this.get("onHoverCell");
      if (onHoverCell) onHoverCell(x, y);
    }
  }
});
