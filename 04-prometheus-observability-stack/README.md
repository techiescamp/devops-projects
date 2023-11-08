# DevOps-Observability FOSS Stack

![Prometheus Server Chart](https://github.com/Allu-Philip/DevOps-Observability/assets/33429916/8287cec1-aa63-4896-9336-83059683c9f5)


## Hit the Star! ⭐
If you are planning to use this DevOps-Observability FOSS Stack repo for learning, please hit the star. Thanks!

## Setup

1. After cloning, we need to change the configuration files `targets.json` and `prometheus.yml`. To automate this process, execute the following script:

    ```bash
    $ cd DevOps-Observability
    $ bash scripts/service-discovery.sh
    ```

2. Once you've made all the necessary changes in the configs, you can spin up the containers:

    ```bash
    $ docker-compose up -d
    $ docker-compose logs -f
    ```

## Access the Webpages

- Prometheus:     [http://your-ip-address:9090](http://your-ip-address:9090)
- Grafana:        [http://your-ip-address:3000](http://your-ip-address:3000)
- Alertmanager:   [http://your-ip-address:9093](http://your-ip-address:9093)
- Node Exporter:  [http://your-ip-address:9100](http://your-ip-address:9100)

## License

This project is licensed under the [Apache License 2.0](LICENSE). You can find the full text of the license in the [LICENSE](LICENSE) file.
