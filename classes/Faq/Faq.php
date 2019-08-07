<?php
/**
* 2007-2019 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author    PrestaShop SA <contact@prestashop.com>
*  @copyright 2007-2019 PrestaShop SA
*  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*/

namespace PrestaShop\Module\PrestashopCheckout\Faq;

use GuzzleHttp\Client;
use GuzzleHttp\Exception\RequestException;

/**
 * Retrieve the faq if the module
 */
class Faq
{
    /**
     * Module key to identifiate on which module we will retrieve the faq
     *
     * @var string
     */
    private $moduleKey;

    /**
     * The version of PrestaShop
     *
     * @var string
     */
    private $psVersion;

    /**
     * In which language the faq will be retrieve
     *
     * @var string
     */
    private $isoCode;

    private $client;

    public function __construct()
    {
        $client = new Client(array(
            'base_url' => 'http://api.addons.prestashop.com/request/faq/',
            'defaults' => array(
                'timeout' => 10,
            ),
        ));

        $this->client = $client;
    }

    /**
     * Wrapper of method post from guzzle client
     *
     * @return array|bool return response or false if no response
     */
    public function getFaq()
    {
        try {
            $response = $this->client->post($this->generateRoute());
        } catch (RequestException $e) {
            \PrestaShopLogger::addLog($e->getMessage());

            if (!$e->hasResponse()) {
                return false;
            }
            $response = $e->getResponse();
        }

        $data = json_decode($response->getBody(), true);

        return isset($data['categories']) && !empty($data['categories']) ? $data : false;
    }

    /**
     * Generate the route to retrieve the faq
     *
     * @return string route
     */
    public function generateRoute()
    {
        return $this->getModuleKey() . '/' . $this->getPsVersion() . '/' . $this->getIsoCode();
    }

    /**
     * Setter moduleKey
     *
     * @param string $moduleKey
     */
    public function setModuleKey($moduleKey)
    {
        $this->moduleKey = $moduleKey;
    }

    /**
     * Setter psVersion
     *
     * @param string $psVersion
     */
    public function setPsVersion($psVersion)
    {
        $this->psVersion = $psVersion;
    }

    /**
     * Setter isoCode
     *
     * @param string $isoCode
     */
    public function setIsoCode($isoCode)
    {
        $this->isoCode = $isoCode;
    }

    /**
     * Getter isoCode
     */
    public function getIsoCode()
    {
        return $this->isoCode;
    }

    /**
     * Getter psVersion
     */
    public function getPsVersion()
    {
        return $this->psVersion;
    }

    /**
     * Getter moduleKey
     */
    public function getModuleKey()
    {
        return $this->moduleKey;
    }
}
