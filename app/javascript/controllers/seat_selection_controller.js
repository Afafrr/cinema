import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['seat', 'counter', 'seatInfo', 'submitButton'];

  update() {
    const selectedSeats = this.seatTargets.filter((seat) => seat.checked);

    this.counterTarget.textContent = selectedSeats.length;
    this.seatInfoTarget.innerHTML = selectedSeats.map((seat) => `<li class='w-fit'>Row: ${seat.dataset.rowNo}, Seat: ${seat.dataset.seatNo}</li>`).join('');
    
    this.submitButtonTarget.disabled = !selectedSeats.length
  }
}
