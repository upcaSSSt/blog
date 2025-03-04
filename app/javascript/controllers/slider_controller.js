import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['slider', 'img', 'slide'];

  connect() {
    this.i = 0;
  }

  close() {
    this.sliderTarget.classList.add('hide');
  }

  open(e) {
    this.sliderTarget.classList.remove('hide');
    this.imgTarget.src = this.slideTargets[e.params.i].src;
    this.i = e.params.i;
  }

  prev() {
    this.i -= 1;
    if (this.i < 0)
      this.i = this.slideTargets.length - 1;
    this.imgTarget.src = this.slideTargets[this.i % this.slideTargets.length].src;
  }

  next() {
    this.imgTarget.src = this.slideTargets[(this.i += 1) % this.slideTargets.length].src;
  }
}
