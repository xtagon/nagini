import Component from '@ember/component';

export default Component.extend({
  classNames: ["board-grid-cell", "grid-cell"],

  onHover: null,

  mouseEnter() {
    const onHover = this.get("onHover");
    if (onHover) onHover();
  }
});
