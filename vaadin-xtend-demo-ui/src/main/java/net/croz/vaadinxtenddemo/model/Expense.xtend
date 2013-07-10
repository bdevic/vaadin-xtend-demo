package net.croz.vaadinxtenddemo.model

import java.util.Date
import java.util.List
import javax.validation.constraints.Future
import javax.validation.constraints.Max
import javax.validation.constraints.Min
import javax.validation.constraints.NotNull
import javax.validation.constraints.Past
import javax.validation.constraints.Size

class Expense {
	@NotNull @Min(1) @Max(100) int organizationalUnit
    @Size(min=5, max=5) String location
	String currentOwner
	List<String> previousOwners
	String expenseType
	String identifier
	@Past Date expenseDate
	@Future Date paymentDate
	@Future Date dueDate

	def int getOrganizationalUnit() {
		return this.organizationalUnit;
	}

	def void setOrganizationalUnit(int organizationalUnit) {
		this.organizationalUnit = organizationalUnit;
	}

	def String getLocation() {
		return this.location;
	}

	def void setLocation(String location) {
		this.location = location;
	}

	def String getCurrentOwner() {
		return this.currentOwner;
	}

	def void setCurrentOwner(String currentOwner) {
		this.currentOwner = currentOwner;
	}

	def List<String> getPreviousOwners() {
		return this.previousOwners;
	}

	def void setPreviousOwners(List<String> previousOwners) {
		this.previousOwners = previousOwners;
	}

	def String getExpenseType() {
		return this.expenseType;
	}

	def void setExpenseType(String expenseType) {
		this.expenseType = expenseType;
	}

	def String getIdentifier() {
		return this.identifier;
	}

	def void setIdentifier(String identifier) {
		this.identifier = identifier;
	}

	def Date getExpenseDate() {
		return this.expenseDate;
	}

	def void setExpenseDate(Date expenseDate) {
		this.expenseDate = expenseDate;
	}

	def Date getPaymentDate() {
		return this.paymentDate;
	}

	def void setPaymentDate(Date paymentDate) {
		this.paymentDate = paymentDate;
	}

	def Date getDueDate() {
		return this.dueDate;
	}

	def void setDueDate(Date dueDate) {
		this.dueDate = dueDate;
	}
}
