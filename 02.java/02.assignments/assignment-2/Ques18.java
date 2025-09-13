// 18. Create a Bank class with a method get InterestRate (). Create subclasses SBI, HDFC,
// and IcICI that override the method with their respective interest rates.
class Bank {
	public double getInterestRate() {
		return 0.0;
	}
}

class SBI extends Bank {
	@Override
	public double getInterestRate() {
		return 6.5;
	}
}

class HDFC extends Bank {
	@Override
	public double getInterestRate() {
		return 7.0;
	}
}

class ICICI extends Bank {
	@Override
	public double getInterestRate() {
		return 6.8;
	}
}

public class Ques18 {
	public static void main(String[] args) {
		Bank sbi = new SBI();
		Bank hdfc = new HDFC();
		Bank icici = new ICICI();
		System.out.println("SBI Interest Rate: " + sbi.getInterestRate() + "%");
		System.out.println("HDFC Interest Rate: " + hdfc.getInterestRate() + "%");
		System.out.println("ICICI Interest Rate: " + icici.getInterestRate() + "%");
	}
}

