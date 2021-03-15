class OrderDetails {
  String key;
  String createdAt;
  String deliveryDate;
  String pickupDate;
  String driverInstruction;
  String instruction;
  String paymentMethod;
  String userAddress;
  String userAddressDetails;
  String status;
  String userId;
  String userPhone;
  String userCity;
  String userFullName;

  OrderDetails(
    this.key,
    this.createdAt,
    this.deliveryDate,
    this.driverInstruction,
    this.instruction,
    this.paymentMethod,
    this.pickupDate,
    this.status,
    this.userAddress,
    this.userAddressDetails,
    this.userId,
    this.userCity,
    this.userFullName,
    this.userPhone,
  );
}
