import { BaseClass } from '../core/dependency-injection/base.class';

export class PslSseService extends BaseClass {
  static Inject = {
    config: 'PsCheckoutConfig',
    $: '$'
  };

  eventSource;

  openConnection()
  {
    // this.eventSource = new EventSource(PsCheckoutConfig.getTokenUrl);
    this.eventSource = new EventSource('http://localhost/sse.php');
  }

  closeConnection()
  {
    this.eventSource.close();
  }

  getPayPalClientToken()
  {
    this.openConnection();
    this.eventSource.addEventListener("getPayPalClientToken", function(e) {
      let data = JSON.parse(e.data);
      console.log(data);
    })

    this.eventSource.onerror = ({ error }) => {
      return error;
    };
  }
}
