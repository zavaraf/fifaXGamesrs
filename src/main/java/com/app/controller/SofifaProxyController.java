package com.app.controller;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.ClientHttpRequestInterceptor;
import org.springframework.http.client.ClientHttpRequestExecution;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import java.io.IOException;

@Controller
@RequestMapping(value = "/rest/sofifa")
public class SofifaProxyController {
    private final String SOFIFA_API = "https://api.sofifa.net";
    private final RestTemplate restTemplate;

    public SofifaProxyController() {
        this.restTemplate = new RestTemplate();
    }

    // Método helper para crear headers que simulan un navegador
    private HttpEntity<Void> createBrowserHeaders() {
        HttpHeaders headers = new HttpHeaders();
        headers.set("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36");
        headers.set("Accept", "application/json, text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8");
        headers.set("Accept-Language", "en-US,en;q=0.5");
        headers.set("Connection", "keep-alive");
        return new HttpEntity<>(headers);
    }

    @RequestMapping(value = "/leagues", method = RequestMethod.GET, headers = "Accept=application/json")
    @ResponseBody
    public ResponseEntity<String> getLeagues() {
        String url = SOFIFA_API + "/leagues";
        return restTemplate.exchange(url, HttpMethod.GET, createBrowserHeaders(), String.class);
    }

    @RequestMapping(value = "/leagues/{roster}", method = RequestMethod.GET, headers = "Accept=application/json")
    @ResponseBody
    public ResponseEntity<String> getLeaguesByRoster(@PathVariable("roster") String roster) {
        String url = SOFIFA_API + "/leagues/" + roster;
        return restTemplate.exchange(url, HttpMethod.GET, createBrowserHeaders(), String.class);
    }

    @RequestMapping(value = "/league/{id}/{roster}", method = RequestMethod.GET, headers = "Accept=application/json")
    @ResponseBody
    public ResponseEntity<String> getTeamsByLeagueAndRoster(@PathVariable("id") int id, @PathVariable("roster") String roster) {
        String url = SOFIFA_API + "/league/" + id + "/" + roster;
        return restTemplate.exchange(url, HttpMethod.GET, createBrowserHeaders(), String.class);
    }

    @RequestMapping(value = "/teams/{roster}", method = RequestMethod.GET, headers = "Accept=application/json")
    @ResponseBody
    public ResponseEntity<String> getTeamsByRoster(@PathVariable("roster") String roster) {
        String url = SOFIFA_API + "/teams/" + roster;
        return restTemplate.exchange(url, HttpMethod.GET, createBrowserHeaders(), String.class);
    }

    @RequestMapping(value = "/team/{id}", method = RequestMethod.GET, headers = "Accept=application/json")
    @ResponseBody
    public ResponseEntity<String> getTeam(@PathVariable("id") int id) {
        String url = SOFIFA_API + "/team/" + id;
        return restTemplate.exchange(url, HttpMethod.GET, createBrowserHeaders(), String.class);
    }

    @RequestMapping(value = "/team/{id}/{roster}", method = RequestMethod.GET, headers = "Accept=application/json")
    @ResponseBody
    public ResponseEntity<String> getTeamByRoster(@PathVariable("id") int id, @PathVariable("roster") String roster) {
        String url = SOFIFA_API + "/team/" + id + "/" + roster;
        return restTemplate.exchange(url, HttpMethod.GET, createBrowserHeaders(), String.class);
    }

    @RequestMapping(value = "/player/{id}", method = RequestMethod.GET, headers = "Accept=application/json")
    @ResponseBody
    public ResponseEntity<String> getPlayer(@PathVariable("id") int id) {
        String url = SOFIFA_API + "/player/" + id;
        return restTemplate.exchange(url, HttpMethod.GET, createBrowserHeaders(), String.class);
    }

    @RequestMapping(value = "/player/{id}/{roster}", method = RequestMethod.GET, headers = "Accept=application/json")
    @ResponseBody
    public ResponseEntity<String> getPlayerByRoster(@PathVariable("id") int id, @PathVariable("roster") String roster) {
        String url = SOFIFA_API + "/player/" + id + "/" + roster;
        return restTemplate.exchange(url, HttpMethod.GET, createBrowserHeaders(), String.class);
    }

    @RequestMapping(value = "/player/{id}/prime", method = RequestMethod.GET, headers = "Accept=application/json")
    @ResponseBody
    public ResponseEntity<String> getPlayerPrime(@PathVariable("id") int id) {
        String url = SOFIFA_API + "/player/" + id + "/prime";
        return restTemplate.exchange(url, HttpMethod.GET, createBrowserHeaders(), String.class);
    }

    @RequestMapping(value = "/customizedPlayers/{apiToken}", method = RequestMethod.GET, headers = "Accept=application/json")
    @ResponseBody
    public ResponseEntity<String> getCustomizedPlayers(@PathVariable("apiToken") String apiToken) {
        String url = SOFIFA_API + "/customizedPlayers/" + apiToken;
        return restTemplate.exchange(url, HttpMethod.GET, createBrowserHeaders(), String.class);
    }

    @RequestMapping(value = "/customizedPlayer/{id}/{apiToken}", method = RequestMethod.GET, headers = "Accept=application/json")
    @ResponseBody
    public ResponseEntity<String> getCustomizedPlayer(@PathVariable("id") int id, @PathVariable("apiToken") String apiToken) {
        String url = SOFIFA_API + "/customizedPlayer/" + id + "/" + apiToken;
        return restTemplate.exchange(url, HttpMethod.GET, createBrowserHeaders(), String.class);
    }

    @RequestMapping(value = "/traits/{version}", method = RequestMethod.GET, headers = "Accept=application/json")
    @ResponseBody
    public ResponseEntity<String> getTraits(@PathVariable("version") String version) {
        String url = SOFIFA_API + "/traits/" + version;
        return restTemplate.exchange(url, HttpMethod.GET, createBrowserHeaders(), String.class);
    }

    @RequestMapping(value = "/playStyles/{version}", method = RequestMethod.GET, headers = "Accept=application/json")
    @ResponseBody
    public ResponseEntity<String> getPlayStyles(@PathVariable("version") String version) {
        String url = SOFIFA_API + "/playStyles/" + version;
        return restTemplate.exchange(url, HttpMethod.GET, createBrowserHeaders(), String.class);
    }

    @RequestMapping(value = "/playStylesPlus/{version}", method = RequestMethod.GET, headers = "Accept=application/json")
    @ResponseBody
    public ResponseEntity<String> getPlayStylesPlus(@PathVariable("version") String version) {
        String url = SOFIFA_API + "/playStylesPlus/" + version;
        return restTemplate.exchange(url, HttpMethod.GET, createBrowserHeaders(), String.class);
    }

    @RequestMapping(value = "/specialities/{version}", method = RequestMethod.GET, headers = "Accept=application/json")
    @ResponseBody
    public ResponseEntity<String> getSpecialities(@PathVariable("version") String version) {
        String url = SOFIFA_API + "/specialities/" + version;
        return restTemplate.exchange(url, HttpMethod.GET, createBrowserHeaders(), String.class);
    }

    @RequestMapping(value = "/playerRole/{version}", method = RequestMethod.GET, headers = "Accept=application/json")
    @ResponseBody
    public ResponseEntity<String> getPlayerRole(@PathVariable("version") String version) {
        String url = SOFIFA_API + "/playerRole/" + version;
        return restTemplate.exchange(url, HttpMethod.GET, createBrowserHeaders(), String.class);
    }

    @RequestMapping(value = "/accelerationType/{version}", method = RequestMethod.GET, headers = "Accept=application/json")
    @ResponseBody
    public ResponseEntity<String> getAccelerationType(@PathVariable("version") String version) {
        String url = SOFIFA_API + "/accelerationType/" + version;
        return restTemplate.exchange(url, HttpMethod.GET, createBrowserHeaders(), String.class);
    }

    @RequestMapping(value = "/myip", method = RequestMethod.GET, headers = "Accept=application/json")
    @ResponseBody
    public ResponseEntity<String> getMyPublicIp() {
        RestTemplate tempRestTemplate = new RestTemplate();
        String myIp = tempRestTemplate.getForObject("https://api.ipify.org", String.class);
        return ResponseEntity.ok(myIp);
    }

    @RequestMapping(value = "/myipv6", method = RequestMethod.GET, headers = "Accept=application/json")
    @ResponseBody
    public ResponseEntity<String> getMyPublicIpv6() {
        RestTemplate tempRestTemplate = new RestTemplate();
        
        String[] ipv6Services = {
            "https://api6.ipify.org",
            "https://v6.ident.me",
            "https://ipv6.icanhazip.com",
            "https://6.ident.me"
        };
        
        for (String service : ipv6Services) {
            try {
                String myIpv6 = tempRestTemplate.getForObject(service, String.class);
                if (myIpv6 != null && !myIpv6.trim().isEmpty()) {
                    return ResponseEntity.ok(myIpv6.trim());
                }
            } catch (Exception e) {
                continue;
            }
        }
        
        return ResponseEntity.ok("IPv6 no disponible - posible falta de conectividad IPv6");
    }

    @RequestMapping(value = "/myips", method = RequestMethod.GET, headers = "Accept=application/json")
    @ResponseBody
    public ResponseEntity<String> getMyPublicIps() {
        RestTemplate tempRestTemplate = new RestTemplate();
        
        String ipv4 = "";
        String ipv6 = "";
        
        try {
            ipv4 = tempRestTemplate.getForObject("https://api.ipify.org", String.class);
            if (ipv4 != null) {
                ipv4 = ipv4.trim();
            }
        } catch (Exception e) {
            ipv4 = "No disponible";
        }
        
        String[] ipv6Services = {
            "https://api6.ipify.org",
            "https://v6.ident.me",
            "https://ipv6.icanhazip.com",
            "https://6.ident.me"
        };
        
        for (String service : ipv6Services) {
            try {
                ipv6 = tempRestTemplate.getForObject(service, String.class);
                if (ipv6 != null && !ipv6.trim().isEmpty()) {
                    ipv6 = ipv6.trim();
                    break;
                }
            } catch (Exception e) {
                continue;
            }
        }
        
        if (ipv6.isEmpty()) {
            ipv6 = "No disponible - posible falta de conectividad IPv6";
        }
        
        String result = "{\"ipv4\":\"" + ipv4 + "\", \"ipv6\":\"" + ipv6 + "\"}";
        return ResponseEntity.ok(result);
    }
}
