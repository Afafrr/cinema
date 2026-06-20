import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="alert"
export default class extends Controller {
  static targets = ['alert'];

  connect() {
    this.remove = () => this.element.remove();

    this.timeout = setTimeout(() => {
      this.element.addEventListener('transitionend', this.remove, { once: true });
      this.element.classList.add('opacity-0');
    }, 3000);
  }

  disconnect() {
    clearTimeout(this.timeout);
    this.element.removeEventListener('transitionend', this.remove);
  }
}