<?php
/**
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
 */

namespace PrestaShop\Module\PrestashopCheckout\Dispatcher;

use PrestaShop\Module\PrestashopCheckout\Exception\PsCheckoutException;
use PrestaShop\Module\PrestashopCheckout\Exception\PsCheckoutSessionException;

class ShopDispatcher implements Dispatcher
{
    /**
     * @var \Ps_checkout
     */
    private $module;

    public function __construct()
    {
        /** @var \Ps_checkout $module */
        $module = \Module::getInstanceByName('ps_checkout');
        $this->module = $module;
    }

    public function dispatchEventType($payload)
    {
        $this->module->getLogger()->debug(
            'Payload',
            [
                'payload' => $payload,
            ]
        );
        if (empty($payload['resource']['shop'])) {
            throw new PsCheckoutException('Unable to find shop aggregate', PsCheckoutException::UNKNOWN);
        }

        /** @var \PrestaShop\Module\PrestashopCheckout\Session\Onboarding\OnboardingSessionManager $onboardingSessionManager */
        $onboardingSessionManager = $this->module->getService('ps_checkout.session.onboarding.manager');
        $openedSession = $onboardingSessionManager->getLatestOpenedSession();
        /** @var \PrestaShop\Module\PrestashopCheckout\Session\SessionConfiguration $sessionConfiguration */
        $sessionConfiguration = $this->module->getService('ps_checkout.session.configuration');
        $onboardingSessionConfiguration = $sessionConfiguration->getOnboarding();

        if (!$openedSession) {
            throw new PsCheckoutSessionException('Unable to find an opened onboarding session', PsCheckoutSessionException::OPENED_SESSION_NOT_FOUND);
        }

        $data = json_decode($openedSession->getData());
        $data->shop = [
            'paypal_onboarding_url' => $payload['resource']['shop']['paypal']['onboard']['links'][1]['href'],
        ];

        $openedSession->setData(json_encode($data));

        foreach ($onboardingSessionConfiguration['transitions'] as $key => $transition) {
            if (isset($transition['from']) && $transition['from'] === $openedSession->getStatus()) {
                $action = $key;
            }
        }

        $this->module->getLogger()->debug(
            'Action',
            [
                'action' => $action,
            ]
        );

        return (bool) $onboardingSessionManager->apply($action, $openedSession->toArray(true));
    }
}
