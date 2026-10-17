# Lab 4 — Performance testing with JMeter (variant 17)

Target: https://www.ctrs.com.ua/ (permanently redirects to https://citrus.ua/).

| File | Purpose |
|------|---------|
| `TestPlans/CTRS_Smoke.jmx`  | 1 user, 1 iteration — checks that the scenario and assertions work |
| `TestPlans/CTRS_Load.jmx`   | 10 users, ramp-up 10 s, 5 iterations — expected load |
| `TestPlans/CTRS_Stress.jmx` | 30 users, ramp-up 30 s, 3 iterations — increased load |
| `Data/search_terms.csv`     | Search queries for the CSV Data Set Config |
| `Results/`                  | `.jtl` files, logs and HTML dashboards of the runs |
| `Screenshots/`              | Images used in the report |
| `run-tests.sh` / `.bat`     | Non-GUI run + HTML report generation |

Scenario of a virtual user: Home → Catalog (smartphones) → Brand page → Product page
(link extracted from the catalog with a Regular Expression Extractor) → Search (`${query}` from CSV) → Promotions.

## Running

GUI: open a `.jmx` file in JMeter (File → Open), press Start (Ctrl+R).

Command line (JMeter 5.6.3, Java 8+):

    ./run-tests.sh all          # or: run-tests.bat all
    jmeter -n -t TestPlans/CTRS_Load.jmx -Jthreads=5 -Jloops=2 -Jhost=citrus.ua -l Results/my.jtl

`threads`, `rampup`, `loops` and `host` are overridable with `-J` properties.
Open `Results/<name>-report/index.html` in a browser to see the dashboard.

Please keep the load moderate: the site is a live commercial service.
