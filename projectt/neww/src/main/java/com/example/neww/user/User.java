package com.example.neww.user;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
public class User {
	@Id
	private int id;
	private String firstName;
	private String lastName;
	private String email;
	private String password;
	private String role;
	public User() {
		
	}
		public User(int id,String firstName,String email,String lastName,String password,String role){
			this.id=id;
			this.firstName=firstName;
			this.lastName=lastName;
			this.email=email;
			this.password=password;
			this.role=role;
		}
		public void setId(int id) {
			this.id=id;
		}
		public int getId() {
			return id;
		}
		public void setFirstName(String firstName) {
			this.firstName=firstName;
		}
		public String getFirstName() {
			return firstName;
		}
		public void setLastName(String lastName) {
			this.lastName=lastName;
		}
		public String getLastName() {
			return lastName;
		}
		public void setemail(String email) {
			this.email=email;
		}
		public String getemail() {
			return email;
		}
		public void setpassword(String password) {
			this.password=password;
		}
		public String getpassword() {
			return password;
		}
		public void setRole(String role) {
			this.role=role;
					}
		public String getRole() {
			return role;
		}
	}

