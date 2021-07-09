<?php
/**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 */

namespace Tests\Unit\Session;

use PHPUnit\Framework\TestCase;
use PrestaShop\Module\PrestashopCheckout\Session\Onboarding\OnboardingSessionManager;
use PrestaShop\Module\PrestashopCheckout\Session\Onboarding\OnboardingSessionRepository;
use PrestaShop\Module\PrestashopCheckout\Session\SessionConfiguration;
use PrestaShop\Module\PrestashopCheckout\Session\Session;
use Tests\Mocks\Configuration;
use Tests\Mocks\Context;
use Tests\Mocks\Db;
use Tests\Mocks\Link;
use Tests\Mocks\Module;
use Tests\Mocks\PaymentModule;
use Tests\Mocks\Ps_checkout;
use Tests\Mocks\Shop;

define('_PS_MODULE_DIR_', '/var/www/html/modules');
define('_PS_VERSION_', '1.7.7.');
define('_PS_ROOT_DIR_', '/var/www/html');
define('_PS_MODE_DEV_', true);

class OnboardingSessionManagerTest extends TestCase
{
    public function testOpenOnboardingSessionSucceed()
    {
        $db = \Mockery::namedMock('Db', Db::class);
        $db->shouldReceive('getInstance')->andReturn($db);

        $link = \Mockery::namedMock('Link', Link::class);

        $shop = \Mockery::namedMock('Shop', Shop::class)->makePartial();
        $shop->shouldReceive();
        $shop->__construct();

        $context = \Mockery::namedMock('Context', Context::class)->makePartial();
        // var_dump($link);
        $context->shouldReceive('getContext')->zeroOrMoreTimes()->set('link', $link)->andSet('shop', $shop)->andReturn($context);

        $configuration = \Mockery::namedMock('Configuration', Configuration::class);
        $configuration->shouldReceive('get')->andReturn('testShopUuid123456');


        $paymentModule = \Mockery::namedMock('PaymentModule', PaymentModule::class)->makePartial();


        $psCheckout = \Mockery::namedMock('Ps_checkout', Ps_checkout::class)->makePartial();
        $psCheckout->shouldReceive()->zeroOrMoreTimes();
        $psCheckout->__construct();

        $module = \Mockery::namedMock('Module', Module::class)->makePartial();
        $module->shouldReceive();
        $module->__construct();

        // var_dump(\Module::getInstanceByName('ps_checkout'));
        // var_dump(new \Ps_checkout());
        // var_dump(new \PaymentModule());

        // $onboardingSessionRepository = $this->createMock(OnboardingSessionRepository::class);
        $onboardingSessionRepository = new OnboardingSessionRepository();
        //
        // // $onboardingSessionRepository->attach($db);
        //
        $sessionConfiguration = new SessionConfiguration();
        $onboardingSessionManager = new OnboardingSessionManager($onboardingSessionRepository, $sessionConfiguration);
        $data = [
            'account_id' => 'testTokenFirebase123456',
            'account_email' => 'test@prestashop.com',
        ];
        // $db = $this->getMockBuilder(Db::class)
        //     ->setMethods(['insert'])
        //     ->getMock();
        //
        // $db->method('insert')
        //     ->willReturn(true);
        //
        // var_dump($onboardingSessionManager);
        $openedOnboardingSession = $onboardingSessionManager->openOnboarding($data);

        // $this->assertContainsOnlyInstancesOf(Session::class, $openedOnboardingSession);
    }

}
