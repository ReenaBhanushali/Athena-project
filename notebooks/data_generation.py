import pandas as pd
import random
import faker
from datetime import datetime


# Initialize Faker
fake = faker.Faker()


# Parameters
num_rows = 1000 # number of log entries
start_date = datetime(2025, 8, 1, 0, 0, 0)
end_date = datetime(2025, 8, 7, 23, 59, 59)


# Sample values
urls = [
"/home",
"/product/123",
"/product/456",
"/product/789",
"/cart",
"/checkout",
"/search?q=shoes",
"/search?q=shirts"
]
status_codes = [200, 200, 200, 404, 500]
user_agents = ["Chrome", "Firefox", "Safari", "Edge", "Opera"]


# Generate synthetic data
data = []
for _ in range(num_rows):
    ip = fake.ipv4()
    ts = start_date + (end_date - start_date) * random.random()
    url = random.choice(urls)
    status = random.choice(status_codes)
    agent = random.choice(user_agents)
    data.append([ip, ts.strftime("%Y-%m-%d %H:%M:%S"), url, status, agent])


# Create DataFrame
df = pd.DataFrame(data, columns=["ip_address", "timestamp", "url", "status_code", "user_agent"])


# Save to CSV
output_file = "web_logs.csv"
df.to_csv(output_file, index=False)
print(f"Synthetic web log data generated and saved to {output_file}")