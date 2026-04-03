import pandas as pd

orders = pd.read_csv("olist_orders_dataset.csv", parse_dates=["order_purchase_timestamp","order_approved_at","order_delivered_carrier_date","order_delivered_customer_date","order_estimated_delivery_date"])
customers = pd.read_csv("olist_customers_dataset.csv")
geolocs = pd.read_csv("olist_geolocation_dataset.csv")
order_items = pd.read_csv("olist_order_items_dataset.csv", parse_dates= ["shipping_limit_date"])
order_payments = pd.read_csv("olist_order_payments_dataset.csv")
order_reviews = pd.read_csv("olist_order_reviews_dataset.csv", parse_dates= ["review_creation_date","review_answer_timestamp"])
products = pd.read_csv("olist_products_dataset.csv")
sellers = pd.read_csv("olist_sellers_dataset.csv")
product_category_names = pd.read_csv("product_category_name_translation.csv")

##Outlier Check on order_items["price"] and order_items["freight_value"]
print('-----Outliers check on order_items["price"]-----')
price_Q1 = order_items["price"].quantile(0.25)
price_Q3 = order_items["price"].quantile(0.75)
price_IQR = price_Q3 - price_Q1

lower_fence1 = price_Q1 - 1.5 * (price_IQR)
higher_fence1 = price_Q3 + 1.5 * (price_IQR)

print(lower_fence1)
print(higher_fence1)
print(order_items["price"].min())
print(order_items["price"].max())

price_outliers = order_items[(order_items['price'] < lower_fence1) | (order_items['price'] >  higher_fence1)]
print(f"total outliers found: {len(price_outliers)}")


print('-----Outliers check on order_items["freight_value"]-----')
Q1 = order_items["freight_value"].quantile(0.25)
Q3 = order_items["freight_value"].quantile(0.75)
IQR = Q3 - Q1

lower_fence = Q1 - 1.5 * (IQR)
higher_fence = Q3 + 1.5 * (IQR)

print(lower_fence)
print(higher_fence)
print(order_items["freight_value"].min())
print(order_items["freight_value"].max())

outliers = order_items[(order_items['freight_value'] < lower_fence) | (order_items['freight_value'] >  higher_fence)]
print(f"total outliers found: {len(outliers)}")

print(outliers[["price","freight_value"]].sort_values(by = "freight_value", ascending = False).head(10))

#Function to check Outliers:
def outlier_func(x):
    Q1 = x.quantile(0.25)
    Q3 = x.quantile(0.75)
    IQR = Q3 - Q1

    lower = Q1 - 1.5 * IQR
    upper = Q3 + 1.5 * IQR

    return x[(x < lower) | (x> upper)]

print(outlier_func(order_payments["payment_value"]).sort_values())

#Date value checks on orders table:
print(orders["order_purchase_timestamp"].min())
print(orders["order_purchase_timestamp"].max())
print(orders["order_approved_at"].min())
print(orders["order_approved_at"].max())
print(orders["order_delivered_carrier_date"].min())
print(orders["order_delivered_carrier_date"].max())
print(orders["order_delivered_customer_date"].min())
print(orders["order_delivered_customer_date"].max())
print(orders["order_estimated_delivery_date"].min())
print(orders["order_estimated_delivery_date"].max())