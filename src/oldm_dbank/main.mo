import Nat "mo:base/Nat";
import Time "mo:base/Time";
import Float "mo:base/Float";
import Debug "mo:base/Debug";

actor DBank {
  stable var currentValue : Float = 300;
  currentValue := 100;

  stable var startTime = Time.now();
  Debug.print(debug_show (startTime));

  let id = 2345453;

  public func topUp(amount : Float) {
    currentValue += amount;
    Debug.print(debug_show (currentValue));
  };

  public func withDrawl(amount : Float) {
    let tempValue : Float = currentValue - amount;
    if (tempValue >= 0) {
      currentValue -= amount;
      Debug.print(debug_show (currentValue));
    } else {
      Debug.print("No funds");
    };
  };

  public query func checkBalance() : async Float {
    return currentValue;
  };

  public func compound() {
    let currentTime = Time.now();
    let timeElapsedNS = currentTime - startTime;
    let timeElapsedS = timeElapsedNS / 1000000000;
    currentValue := currentValue * (1.01 ** Float.fromInt(timeElapsedS));
    startTime := currentTime;
  };

};
