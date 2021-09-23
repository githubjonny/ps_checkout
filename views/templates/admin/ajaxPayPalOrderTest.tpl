<style>
  #ps_checkout .panel-wrapper {
    flex-grow: 1;
    padding: 18px 14px;
    border: 2px solid #e4ebf3;
    margin-bottom: 10px;
  }
  #ps_checkout .panel {
    background: none;
    box-shadow: none;
    text-align: left;
    color: #555555;
    position: relative;
  }
  #ps_checkout .panel__title, #ps_checkout .tabpanel__title {
    display: block;
    color: #878787;
    margin: 0;
    padding-bottom: 8px;
    border-bottom: 1px solid #eeeeee;
  }
  #ps_checkout .panel__infos {
    margin-top: 16px;
    margin-bottom: 0;
    padding-bottom: 16px;
    display: grid;
    grid-template-columns: 116px 1fr;
    grid-column-gap: 16px;
    grid-row-gap: 8px;
  }
  #ps_checkout .panel__infos dd {
    font-weight: 400;
    text-align: right;
  }
  #ps_checkout .panel__cta {
    text-align: center;
  }
  #ps_checkout .panel__cta a {
    font-weight: 600;
    color: #555;
    text-decoration: underline;
    text-align: center;
    display: inline-block;
  }
  #ps_checkout .select-wrapper {
    margin-bottom: 1.5em;
  }
  #ps_checkout .select-wrapper__select {
    width: 100%;
    background-color: #fff;
    border: 1px solid #B3C7CD;
    border-radius: 3px;
    color: #363A41;
    padding: 0.5em;
  }
  #ps_checkout .tabs {
    color: #555555;
    position: relative;
  }
  #ps_checkout [role="tablist"] {
    position: absolute;
    top: 0;
    left: 0;
    max-height: 100%;
    height: 100%;
    display: none;
    overflow-y: scroll;
    overflow-x: hidden;
  }
  #ps_checkout .tab {
    background: none;
    box-shadow: none;
    text-align: left;
    padding: 20px 14px;
    color: #555555;
    border: 2px solid #e5ebf3;
    border-bottom: none;
    cursor: pointer;
  }
  #ps_checkout .tab:last-child{
    border-bottom: 2px solid #e5ebf3;
  }
  #ps_checkout .tab:focus{
    outline: none;
  }
  #ps_checkout .tab[aria-selected="true"] {
    border-right: 2px solid #fff;
    position: relative;
    z-index: 2;
  }
  #ps_checkout .tab__btn-title {
    display: block;
    margin-bottom: 8px;
  }
  #ps_checkout .tab__btn-infos {
    display: flex;
    justify-content: space-between;
  }
  #ps_checkout .tabpanel-wrapper {
    flex-grow: 1;
    padding: 18px 14px;
    border: 2px solid #e5ebf3;
  }
  #ps_checkout .tabpanel {
    position: relative;
  }
  #ps_checkout .tabpanel__infos {
    margin-top: 16px;
    margin-bottom: 0;
    padding-bottom: 16px;
    display: grid;
    grid-template-columns: 116px 1fr;
    grid-column-gap: 16px;
    grid-row-gap: 8px;
  }
  .tabpanel__infos + .tabpanel__infos {
    padding-bottom: 0;
  }
  #ps_checkout .tabpanel__infos dd {
    font-weight: 700;
    text-align: right;
  }
  #ps_checkout .tabpanel__cta {
    font-weight: 600;
    color: #555;
    text-decoration: underline;
    text-align: center;
    display: block;
  }
  #ps_checkout .tabpanel__cta:after {
    content: '';
    display: inline-block;
    vertical-align: middle;
    margin-left: 0.8em;
    text-decoration: none;
    width: 1.15em;
    height: 1.15em;
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' height='24' viewBox='0 0 24 24' width='24'%3E%3Cpath d='M0 0h24v24H0z' fill='none'/%3E%3Cpath d='M19 19H5V5h7V3H5c-1.11 0-2 .9-2 2v14c0 1.1.89 2 2 2h14c1.1 0 2-.9 2-2v-7h-2v7zM14 3v2h3.59l-9.83 9.83 1.41 1.41L19 6.41V10h2V3h-7z'/%3E%3C/svg%3E");
    background-size: contain;
  }
  @media screen and (min-width: 780px) {
    #ps_checkout .panel__cta {
      position: absolute;
      top: 0;
      right: 0;
    }
    #ps_checkout .panel__infos dd {
      text-align: left;
    }
    #ps_checkout .select-wrapper {
      display: none;
    }
    #ps_checkout .tabs {
      display: flex;
      padding-left: 244px;
    }
    #ps_checkout [role="tablist"] {
      display: flex;
      flex-direction: column;
      width: 254px;
      flex-shrink: 0;
    }
    #ps_checkout .panel__infos {
      grid-template-columns: max-content;
      grid-template-areas:
            "reference referenceValue total totalValue payment paymentValue"
            "status statusValue balance balanceValue empty empty";
    }
    #ps_checkout [data-grid-area="reference"] {
      grid-area: reference;
    }
    #ps_checkout [data-grid-area="reference"] + dd {
      grid-area: referenceValue;
    }
    #ps_checkout [data-grid-area="total"] {
      grid-area: total;
    }
    #ps_checkout [data-grid-area="total"] + dd {
      grid-area: totalValue;
    }
    #ps_checkout [data-grid-area="payment"] {
      grid-area: payment;
    }
    #ps_checkout [data-grid-area="payment"] + dd {
      grid-area: paymentValue;
    }
    #ps_checkout [data-grid-area="status"] {
      grid-area: status;
    }
    #ps_checkout [data-grid-area="status"] + dd {
      grid-area: statusValue;
    }
    #ps_checkout [data-grid-area="balance"] {
      grid-area: balance;
    }
    #ps_checkout [data-grid-area="balance"] + dd {
      grid-area: balanceValue;
    }
    #ps_checkout .tabpanel__infos dd {
      font-weight: 700;
      text-align: left;
    }
    #ps_checkout .tabpanel__cta {
      position: absolute;
      top: 0;
      right: 0;
    }
  }

  /* width */
  #ps_checkout [role="tablist"]::-webkit-scrollbar {
    width: 8px;
  }

  #ps_checkout [role="tablist"]::-webkit-scrollbar-thumb {
    background: rgba(169, 169, 169, 0.15);
    border-radius: 20px;
  }

  /*!* Handle on hover *!*/
  #ps_checkout [role="tablist"]::-webkit-scrollbar-thumb:hover {
    background: rgba(56, 56, 56, 0.33);
  }

  #ps_checkout .balance-info-icon:after {
    font-style: normal;
    font-family: "Material Icons";
    content: "\E001";
    display: inline-block;
    vertical-align: middle;
    color: #878787;
  }
</style>
<div>
  <div class="panel-wrapper">
    <div class="panel">
      <h5 class="panel__title">PayPal Order</h5>
      <dl class="panel__infos">
        <dt data-grid-area="reference">Reference</dt>
        <dd>52H89473K1568603N</dd>
        <dt data-grid-area="status">Status</dt>
        <dd>Completed</dd>
        <dt data-grid-area="total">Total</dt>
        <dd>€125,00</dd>
        <dt data-grid-area="balance">
          Balance
          <i class="balance-info-icon" title="{l s='Total amount you will receive on your bank account: the order amount, minus transaction fees, minus potential refunds' mod='ps_checkout'}"></i>
        </dt>
        <dd>+ €95,00</dd>
        <dt data-grid-area="payment">Payment mode</dt>
        <dd>PayPal</dd>
      </dl>
      <div class="panel__cta">
        Any change on the order?
        <button class="refund">
          Refund
        </button>
      </div>
    </div>
  </div>
  <div class="select-wrapper">
    <select name="select-tab" id="select-transaction" class="select-wrapper__select">
      <option value="first-tab">24/02/2021 12:51:57 - Payment + 125€</option>
      <option value="second-tab">24/02/2021 12:51:57 - Refund - 25€</option>
      <option value="third-tab">24/02/2021 12:51:57 - Refund - 25€</option>
    </select>
  </div>
  <div class="tabs">
    <!-- START > TABLIST -->
    <!-- tablist is the list of buttons to show/hide tab
        they work with an aria-selected attribute. when set to true, you should show it's corresponding pannel -->
    <div role="tablist" aria-label="Orders">
      <button
        role="tab"
        aria-selected="true"
        aria-controls="first-tab"
        id="first"
        class="tab"
      >
        <strong class="tab__btn-title"> Payment </strong>
        <span class="tab__btn-infos">
              <span class="tab__btn-time">24/02/2021 12:51:57</span>
              <strong class="tab__btn-amount">+ €125,00</strong>
            </span>
      </button>
      <button
        role="tab"
        aria-selected="false"
        aria-controls="second-tab"
        id="second"
        tabindex="-1"
        class="tab"
      >
        <strong class="tab__btn-title"> Refund </strong>
        <span class="tab__btn-infos">
              <span class="tab__btn-time">24/02/2021 12:51:57</span>
              <strong class="tab__btn-amount">- €25,00</strong>
            </span>
      </button>
      <button
        role="tab"
        aria-selected="false"
        aria-controls="third-tab"
        id="third"
        data-deletable=""
        tabindex="-1"
        class="tab"
      >
        <strong class="tab__btn-title"> Refund </strong>
        <span class="tab__btn-infos">
              <span class="tab__btn-time">24/02/2021 12:51:57</span>
              <strong class="tab__btn-amount">- €25,00</strong>
            </span>
      </button>
      <button
        role="tab"
        aria-selected="false"
        aria-controls="third-tab"
        id="third"
        data-deletable=""
        tabindex="-1"
        class="tab"
      >
        <strong class="tab__btn-title"> Refund </strong>
        <span class="tab__btn-infos">
              <span class="tab__btn-time">24/02/2021 12:51:57</span>
              <strong class="tab__btn-amount">- €25,00</strong>
            </span>
      </button>
      <button
        role="tab"
        aria-selected="false"
        aria-controls="third-tab"
        id="third"
        data-deletable=""
        tabindex="-1"
        class="tab"
      >
        <strong class="tab__btn-title"> Refund </strong>
        <span class="tab__btn-infos">
              <span class="tab__btn-time">24/02/2021 12:51:57</span>
              <strong class="tab__btn-amount">- €25,00</strong>
            </span>
      </button>
    </div>
    <!-- END > TABLIST -->

    <!-- tabpanel wrapper is the wrapper containing all panel of content -->
    <div class="tabpanel-wrapper">
      <!-- START > TABPANEL -->
      <!-- See id, it must correspond to aria control in tablist -->
      <div
        tabindex="0"
        role="tabpanel"
        id="first-tab"
        aria-labelledby="first"
        class="tabpanel"
      >
        <div>
          <div>
            <h5 class="tabpanel__title">Transaction details</h5>
            <dl class="tabpanel__infos">
              <dt>Reference</dt>
              <dd>TARTIFLETTE2568498</dd>
              <dt>Status</dt>
              <dd>Completed</dd>
              <dt>Amount (Tax incl.)</dt>
              <dd>€125,00</dd>
            </dl>
          </div>
          <div>
            <h5 class="tabpanel__title">Transaction amounts</h5>
            <dl class="tabpanel__infos">
              <dt>Gross amount</dt>
              <dd>€125,00</dd>
              <dt>Fees (Tax Incl.)</dt>
              <dd>- €15,00</dd>
              <dt>Net amount</dt>
              <dd>€110,00</dd>
            </dl>
          </div>
          <a href="#" target="_blank" class="tabpanel__cta"
          >See on PayPal</a
          >
        </div>
      </div>
      <!-- END > TABPANEL -->
      <!-- START > TABPANEL -->
      <!-- See, it's not the panel selected, there is hdden attribute set to hidden -->
      <div
        tabindex="0"
        role="tabpanel"
        id="second-tab"
        aria-labelledby="second"
        class="tabpanel"
        hidden="hidden"
      >
        <div>
          <div>
            <h5 class="tabpanel__title">Transaction details</h5>
            <dl class="tabpanel__infos">
              <dt>Reference</dt>
              <dd>2CA98997587871237</dd>
              <dt>Status</dt>
              <dd>Completed</dd>
              <dt>Amount (Tax incl.)</dt>
              <dd>€125,00</dd>
            </dl>
          </div>
          <div>
            <h5 class="tabpanel__title">Transaction amounts</h5>
            <dl class="tabpanel__infos">
              <dt>Gross amount</dt>
              <dd>€125,00</dd>
              <dt>Fees (Tax Incl.)</dt>
              <dd>- €15,00</dd>
              <dt>Net amount</dt>
              <dd>€110,00</dd>
            </dl>
          </div>
          <a href="#" target="_blank" class="tabpanel__cta"
          >See on PayPal</a
          >
        </div>
      </div>
      <!-- END > TABPANEL -->
      <!-- START > TABPANEL -->
      <div
        tabindex="0"
        role="tabpanel"
        id="third-tab"
        aria-labelledby="third"
        hidden="hidden"
        class="tabpanel"
      >
        <div>
          <div>
            <h5 class="tabpanel__title">Transaction details</h5>
            <dl class="tabpanel__infos">
              <dt>Reference</dt>
              <dd>2CA9789706540</dd>
              <dt>Status</dt>
              <dd>Completed</dd>
              <dt>Amount (Tax incl.)</dt>
              <dd>€150,00</dd>
            </dl>
          </div>
          <div>
            <h5 class="tabpanel__title">Transaction amounts</h5>
            <dl class="tabpanel__infos">
              <dt>Gross amount</dt>
              <dd>€125,00</dd>
              <dt>Fees (Tax Incl.)</dt>
              <dd>- €15,00</dd>
              <dt>Net amount</dt>
              <dd>€110,00</dd>
            </dl>
          </div>
          <a href="#" target="_blank" class="tabpanel__cta">
            See on PayPal
          </a>
        </div>
      </div>
      <!-- END > TABPANEL -->
    </div>
  </div>
</div>
<script>
  /*
  *   This content is licensed according to the W3C Software License at
  *   https://www.w3.org/Consortium/Legal/2015/copyright-software-and-document
  */
  $(document).ready(function () {

  })
</script>
