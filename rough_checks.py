import pandas as pd

cust = pd.read_csv("olist_customers_dataset.csv")
geoloc = pd.read_csv("olist_geolocation_dataset.csv")
order_items = pd.read_csv("olist_order_items_dataset.csv")
order_payments = pd.read_csv("olist_order_payments_dataset.csv")
order_reviews = pd.read_csv("olist_order_reviews_dataset.csv")
orders = pd.read_csv("olist_orders_dataset.csv")
products = pd.read_csv("olist_products_dataset.csv")
sellers = pd.read_csv("olist_sellers_dataset.csv")
product_cat_name = pd.read_csv("product_category_name_translation.csv")

print("---------------------check from here----------------")
print(cust.info())
print(geoloc.info())
print(order_items.info())
print(f" minimum date on shipping limit column {order_items["shipping_limit_date"].min()} /n Maximum date on shipping limit column {order_items["shipping_limit_date"].max()}")
print(orders["order_purchase_timestamp"].max())


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


#------------
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



pv_q1 = order_payments["payment_value"].quantile(0.25)
pv_q3 = order_payments["payment_value"].quantile(0.75)

pv_IQR = pv_q3 - pv_q1

pv_lower_fence = pv_q1 - 1.5 * pv_IQR
pv_higher_fence = pv_q3 + 1.5 * pv_IQR

print("PV CHECK")
print(pv_lower_fence)
print(pv_higher_fence)
print(order_payments["payment_value"].min())
print(order_payments["payment_value"].max())

pv_outliers = order_payments[(order_payments["payment_value"] < pv_lower_fence) | (order_payments["payment_value"] > pv_higher_fence)]

print(f'lenght of outliers {len(pv_outliers)} ' )
print(order_payments.info())


print(orders.info())

print(products.info())


def outlier_func(x):
    Q1 = x.quantile(0.25)
    Q3 = x.quantile(0.75)
    IQR = Q3 - Q1

    lower = Q1 - 1.5 * IQR
    upper = Q3 + 1.5 * IQR

    return x[(x < lower) | (x> upper)]

print(outlier_func(order_payments["payment_value"]).sort_values())

print(orders.corr())
