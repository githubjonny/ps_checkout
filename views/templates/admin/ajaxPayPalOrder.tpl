{**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License version 3.0
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * @author    PrestaShop SA and Contributors <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License version 3.0
 *}

<div class="info-block">
  <div class="row mt-3">
    <div class="col-md-6">
      <p class="mb-1">
        <strong>
          {l s='PayPal Order Id' mod='ps_checkout'}
        </strong>
      </p>
      <p>
        {$orderPayPal.id|escape:'html':'UTF-8'}
      </p>
    </div>
    <div class="col-md-6">
      <p class="mb-1">
        <strong>{l s='PayPal Order Status' mod='ps_checkout'}</strong>
      </p>
      <p>
        <span class="badge rounded badge-{$orderPayPal.status.class|escape:'html':'UTF-8'}" data-value="{$orderPayPal.status.value|escape:'html':'UTF-8'}">
          {$orderPayPal.status.translated|escape:'html':'UTF-8'}
        </span>
      </p>
    </div>
  </div>
</div>
{if !empty($orderPayPal.transactions)}
  <table class="table">
    <thead>
    <tr>
      <th>{l s='Date' mod='ps_checkout'}</th>
      <th>{l s='Type' mod='ps_checkout'}</th>
      <th>{l s='Transaction ID' mod='ps_checkout'}</th>
      <th>{l s='Status' mod='ps_checkout'}</th>
      <th>{l s='Amount (Tax included)' mod='ps_checkout'}</th>
      <th></th>
    </tr>
    </thead>
    <tbody>
    {foreach $orderPayPal.transactions as $orderPayPalTransaction}
      <tr>
        <td>
          {dateFormat date=$orderPayPalTransaction.date full=true}
        </td>
        <td>
        <span class="badge rounded badge-{$orderPayPalTransaction.type.class|escape:'html':'UTF-8'}" data-value="{$orderPayPalTransaction.type.value|escape:'html':'UTF-8'}">
        {$orderPayPalTransaction.type.translated|escape:'html':'UTF-8'}
      </span>
        </td>
        <td>
          {$orderPayPalTransaction.id|escape:'html':'UTF-8'}
        </td>
        <td>
        <span class="badge rounded badge-{$orderPayPalTransaction.status.class|escape:'html':'UTF-8'}" data-value="{$orderPayPalTransaction.status.value|escape:'html':'UTF-8'}">
        {$orderPayPalTransaction.status.translated|escape:'html':'UTF-8'}
      </span>
        </td>
        <td>
          {$orderPayPalTransaction.amount|escape:'html':'UTF-8'} {$orderPayPalTransaction.currency|escape:'html':'UTF-8'}
        </td>
        <td class="text-right">
          {if $orderPayPalTransaction.isRefundable}
            <button type="button" class="btn btn-primary btn-sm refund" data-transaction-id="{$orderPayPalTransaction.id|escape:'html':'UTF-8'}">
              {l s='Refund' mod='ps_checkout'}
            </button>
          {/if}
          <a class="btn btn-sm btn-outline-secondary" target="_blank" href="https://www.paypal.com/activity/payment/{$orderPayPalTransaction.id|escape:'html':'UTF-8'}">
            {l s='Details' mod='ps_checkout'}
          </a>
        </td>
      </tr>
    {/foreach}
    </tbody>
  </table>
  {foreach $orderPayPal.transactions as $orderPayPalTransaction}
    {if $orderPayPalTransaction.isRefundable}
      {assign var="maxAmountRefundable" value=$orderPayPalTransaction.maxAmountRefundable|string_format:"%.2f"}
      {assign var="orderPayPalRefundAmountIdentifier" value='orderPayPalRefundAmount'|cat:$orderPayPalTransaction.id}
      <div id="ps-checkout-refund-{$orderPayPalTransaction.id|escape:'html':'UTF-8'}" class="modal fade ps-checkout-refund" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
          <div class="modal-content">
            <form action="{$orderPayPalBaseUrl|escape:'html':'UTF-8'}" method="POST" class="form-horizontal ps-checkout-refund-form">
              <div class="modal-header">
                <h5 class="modal-title">
                  {$moduleName|escape:'html':'UTF-8'} - {l s='Refund' mod='ps_checkout'}
                </h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="{l s='Cancel' mod='ps_checkout'}">
                  <span aria-hidden="true">×</span>
                </button>
              </div>
              <div class="modal-body mb-2">
                <div class="modal-notifications">
                </div>
                <div class="modal-content-container">
                  <input name="ajax" type="hidden" value="1">
                  <input name="action" type="hidden" value="RefundOrder">
                  <input name="orderPayPalRefundTransaction" type="hidden" value="{$orderPayPalTransaction.id|escape:'html':'UTF-8'}">
                  <input name="orderPayPalRefundOrder" type="hidden" value="{$orderPayPal.id|escape:'html':'UTF-8'}">
                  <input name="orderPayPalRefundCurrency" type="hidden" value="{$orderPayPalTransaction.currency|escape:'html':'UTF-8'}">
                  <p class="text-muted">
                    {l s='Your transaction refund request will be sent to PayPal. After that, you’ll need to manually process the refund action in the PrestaShop order: choose the type of refund (standard or partial) in order to generate credit slip.' mod='ps_checkout'}
                  </p>
                  <div class="form-group mb-0">
                    <label class="form-control-label" for="{$orderPayPalRefundAmountIdentifier|escape:'html':'UTF-8'}">
                      {l s='Choose amount to refund (tax included)' mod='ps_checkout'}
                    </label>
                    <div class="row">
                      <div class="col-md-4">
                        <div class="input-group-append">
                          <input
                                  class="form-control text-right"
                                  name="orderPayPalRefundAmount"
                                  id="{$orderPayPalRefundAmountIdentifier|escape:'html':'UTF-8'}"
                                  type="number"
                                  step=".01"
                                  min="0.01"
                                  max="{$maxAmountRefundable|escape:'html':'UTF-8'}"
                                  value="{$maxAmountRefundable|escape:'html':'UTF-8'}"
                          >
                          <div class="input-group-text">{$orderPayPalTransaction.currency|escape:'html':'UTF-8'}</div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <p class="text-muted">
                    {l s='Maximum [AMOUNT_MAX] [CURRENCY] (tax included)' sprintf=['[AMOUNT_MAX]' => $orderPayPalTransaction.maxAmountRefundable|escape:'html':'UTF-8'|string_format:"%.2f", '[CURRENCY]' => $orderPayPalTransaction.currency|escape:'html':'UTF-8'] mod='ps_checkout'}
                  </p>
                </div>
                <div class="modal-loader text-center">
                  <button class="btn-primary-reverse onclick unbind spinner"></button>
                </div>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">
                  {l s='Cancel' mod='ps_checkout'}
                </button>
                <button type="submit" class="btn btn-primary">
                  {l s='Refund' mod='ps_checkout'}
                </button>
              </div>
            </form>
          </div>
        </div>
      </div>
    {/if}
  {/foreach}
{/if}

{var_dump($orderPayPal)}

<div>
  <div class="panel-wrapper">
    <div class="panel">
      <h3 class="panel__title">{l s='PayPal Order' mod='ps_checkout'}</h3>
      <dl class="panel__infos">
        <dt data-grid-area="reference">{l s='Reference' mod='ps_checkout'}</dt>
        <dd>{$orderPayPal.id|escape:'html':'UTF-8'}</dd>
        <dt data-grid-area="status">{l s='Status' mod='ps_checkout'}</dt>
        <dd>
          <span class="badge rounded badge-{$orderPayPal.status.class|escape:'html':'UTF-8'}" data-value="{$orderPayPal.status.value|escape:'html':'UTF-8'}">
            {$orderPayPal.status.translated|escape:'html':'UTF-8'}
          </span>
        </dd>
        <dt data-grid-area="total">{l s='Total' mod='ps_checkout'}</dt>
        <dd>{$orderPayPal.total}</dd>
        <dt data-grid-area="balance">{l s='Balance' mod='ps_checkout'}</dt>
        <dd>{$orderPayPal.balance}</dd>
        <dt data-grid-area="payment">{l s='Payment mode' mod='ps_checkout'}</dt>
        <dd>{$orderPayPal.payment_mode}</dd>
      </dl>
      <div class="panel__cta">
          {l s='Any change on the order?' mod='ps_checkout'}
        <a href="#" target="_blank">
            {l s='Refund' mod='ps_checkout'}
        </a>
      </div>
    </div>
  </div>
  {if !empty($orderPayPal.transactions)}
    <div class="select-wrapper">
      <select name="select-tab" id="select-transaction" class="select-wrapper__select">
        {foreach $orderPayPal.transactions as $orderPayPalTransaction}
          <option value="{$orderPayPalTransaction.id}-tab">{dateFormat date=$orderPayPalTransaction.date full=true} - {$orderPayPalTransaction.type.translated|escape:'html':'UTF-8'} | {$orderPayPalTransaction.amount|escape:'html':'UTF-8'} {$orderPayPalTransaction.currency|escape:'html':'UTF-8'}</option>
        {/foreach}
      </select>
    </div>

    <div class="tabs">
      <div role="tablist" aria-label="Transactions">
        {foreach $orderPayPal.transactions as $key => $orderPayPalTransaction}
          <button
            role="tab"
            aria-selected="{if $key eq 0}true{else}false{/if}"
            aria-controls="{$orderPayPalTransaction.id}-tab"
            class="tab"
          >
            <strong class="tab__btn-title"> {$orderPayPalTransaction.type.translated|escape:'html':'UTF-8'} </strong>
            <span class="tab__btn-infos">
                <span class="tab__btn-time">{dateFormat date=$orderPayPalTransaction.date full=true}</span>
                <strong class="tab__btn-amount">{$orderPayPalTransaction.amount|escape:'html':'UTF-8'} {$orderPayPalTransaction.currency|escape:'html':'UTF-8'}</strong>
              </span>
          </button>
        {/foreach}
      </div>

      <div class="tabpanel-wrapper">
        {foreach $orderPayPal.transactions as $key => $orderPayPalTransaction}
        <div
          tabindex="0"
          role="tabpanel"
          id="{$orderPayPalTransaction.id}-tab"
          aria-labelledby="first"
          class="tabpanel"
          {if $key neq 0}hidden="hidden"{/if}
        >
          <div>
            <div>
              <h3 class="tabpanel__title">{l s='Transaction details' mod='ps_checkout'}</h3>
              <dl class="tabpanel__infos">
                <dt>{l s='Reference' mod='ps_checkout'}</dt>
                <dd>{$orderPayPalTransaction.id}</dd>
                <dt>{l s='Status' mod='ps_checkout'}</dt>
                <dd>{$orderPayPalTransaction.status.translated}</dd>
                <dt>{l s='Amount (Tax incl.)' mod='ps_checkout'}</dt>
                <dd>{$orderPayPalTransaction.amount} {$orderPayPalTransaction.currency}</dd>
              </dl>
            </div>
            <div>
              <h3 class="tabpanel__title">Transaction amounts</h3>
              <dl class="tabpanel__infos">
                <dt>{l s='Gross amount' mod='ps_checkout'}</dt>
                <dd>€125,00</dd>
                <dt>{l s='Fees (Tax Incl.)' mod='ps_checkout'}</dt>
                <dd>- €15,00</dd>
                <dt>{l s='Net amount' mod='ps_checkout'}</dt>
                <dd>€110,00</dd>
              </dl>
            </div>
            <a href="https://www.paypal.com/activity/payment/{$orderPayPalTransaction.id|escape:'html':'UTF-8'}" target="_blank" class="tabpanel__cta">
              {l s='See on PayPal' mod='ps_checkout'}
            </a>
          </div>
        </div>
        {/foreach}
      </div>
    </div>
  {/if}
</div>

<style>
  #ps_checkout .badge.badge-payment {
    background-color: #00B887;
    color: #fff;
  }

  #ps_checkout .badge.badge-refund {
    background-color: #34219E;
    color: #fff;
  }
</style>
<style>
  .panel-wrapper {
    flex-grow: 1;
    padding: 18px 14px;
    border: 2px solid #e5ebf3;
    margin-bottom: 10px;
  }
  .panel {
    background: none;
    box-shadow: none;
    text-align: left;
    color: #555555;
    position: relative;
  }
  .panel__title, .tabpanel__title {
    display: block;
    color: #878787;
    margin: 0;
    padding-bottom: 8px;
    border-bottom: 1px solid #eeeeee;
  }
  .panel__infos {
    margin-top: 16px;
    margin-bottom: 0;
    padding-bottom: 16px;
    display: grid;
    grid-template-columns: 116px 1fr;
    grid-column-gap: 16px;
    grid-row-gap: 8px;
  }
  .panel__infos dd {
    font-weight: 400;
    text-align: right;
  }
  .panel__cta {
    text-align: center;
  }
  .panel__cta a {
    font-weight: 600;
    color: #555;
    text-decoration: underline;
    text-align: center;
    display: inline-block;
  }
  .select-wrapper {
    margin-bottom: 1.5em;
  }
  .select-wrapper__select {
    width: 100%;
    background-color: #fff;
    border: 1px solid #B3C7CD;
    border-radius: 3px;
    color: #363A41;
    padding: 0.5em;
  }
  .tabs {
    color: #555555;
  }
  [role="tablist"] {
    display: none;
  }
  .tab {
    border: none;
    background: none;
    box-shadow: none;
    text-align: left;
    padding: 20px 14px;
    color: #555555;
    border-bottom: 2px solid #e5ebf3;
    border-left: 2px solid #e5ebf3;
  }
  .tab[aria-selected="true"] {
    border-right: 2px solid #fff;
    margin-right: -2px;
    position: relative;
    z-index: 2;
  }
  .tab {
    cursor: pointer;
  }
  .tab__btn-title {
    display: block;
    margin-bottom: 8px;
  }
  .tab__btn-infos {
    display: flex;
    justify-content: space-between;
  }
  .tabpanel-wrapper {
    flex-grow: 1;
    padding: 18px 14px;
    border: 2px solid #e5ebf3;
  }
  .tabpanel {
    position: relative;
  }
  .tabpanel__infos {
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
  .tabpanel__infos dd {
    font-weight: 700;
    text-align: right;
  }
  .tabpanel__cta {
    font-weight: 600;
    color: #555;
    text-decoration: underline;
    text-align: center;
    display: block;
  }
  .tabpanel__cta:after {
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
    .panel__cta {
      position: absolute;
      top: 0;
      right: 0;
    }
    .panel__infos dd {
      text-align: left;
    }
    .select-wrapper {
      display: none;
    }
    .tabs {
      display: flex;
    }
    [role="tablist"] {
      display: flex;
      flex-direction: column;
      border-top: 2px solid #e5ebf3;
      width: 244px;
      flex-shrink: 0;
    }
    .panel__infos {
      grid-template-columns: max-content;
      grid-template-areas:
            "reference referenceValue total totalValue payment paymentValue"
            "status statusValue balance balanceValue empty empty";
    }
    [data-grid-area="reference"] {
      grid-area: reference;
    }
    [data-grid-area="reference"] + dd {
      grid-area: referenceValue;
    }
    [data-grid-area="total"] {
      grid-area: total;
    }
    [data-grid-area="total"] + dd {
      grid-area: totalValue;
    }
    [data-grid-area="payment"] {
      grid-area: payment;
    }
    [data-grid-area="payment"] + dd {
      grid-area: paymentValue;
    }
    [data-grid-area="status"] {
      grid-area: status;
    }
    [data-grid-area="status"] + dd {
      grid-area: statusValue;
    }
    [data-grid-area="balance"] {
      grid-area: balance;
    }
    [data-grid-area="balance"] + dd {
      grid-area: balanceValue;
    }
    .tabpanel__infos dd {
      font-weight: 700;
      text-align: left;
    }
    .tabpanel__cta {
      position: absolute;
      top: 0;
      right: 0;
    }
  }
</style>
