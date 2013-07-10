package net.croz.vaadinxtenddemo.api

import com.vaadin.ui.Button
import com.vaadin.ui.ComboBox
import com.vaadin.ui.Component
import com.vaadin.ui.ComponentContainer
import com.vaadin.ui.FormLayout
import com.vaadin.ui.GridLayout
import com.vaadin.ui.HorizontalLayout
import com.vaadin.ui.Image
import com.vaadin.ui.Label
import com.vaadin.ui.Panel
import com.vaadin.ui.PasswordField
import com.vaadin.ui.Table
import com.vaadin.ui.TextField
import com.vaadin.ui.VerticalLayout
import com.vaadin.ui.Window

class BuilderExtensions {

	static def window((Window)=>void initializer) {
		new Window().init(initializer)
	}

	static def panel(ComponentContainer it, (Panel)=>void initializer) {
		val that = new Panel()
		it.addComponent(that)
		that.init(initializer)
		return that
	}

	static def lastComponent(ComponentContainer it) {
		return it.iterator().last
	}

	static def <T extends Component> component(ComponentContainer it, T component, (T)=>void initializer) {
		it.addComponent(component)
		component.init(initializer)
		return component
	}
	
	static def <T extends Component> component(ComponentContainer it, Class<T> clazz, (T)=>void initializer) {
		val component = clazz.newInstance
		it.addComponent(component)
		component.init(initializer)
		return component
	}

	static def verticalLayout(ComponentContainer it, (VerticalLayout)=>void initializer) {
		val that = new VerticalLayout();
		it.addComponent(that);
		that.init(initializer);
		return that
	}

	static def horizontalLayout(ComponentContainer it, (HorizontalLayout)=>void initializer) {
		val that = new HorizontalLayout()
		it.addComponent(that);
		that.init(initializer)
		return that
	}
	
	static def formLayout(ComponentContainer it, (FormLayout)=>void initializer) {
		val that = new FormLayout()
		it.addComponent(that);
		that.init(initializer)
		return that
	}
	
	static def gridLayout(ComponentContainer it, (GridLayout)=>void initializer) {
		val that = new GridLayout()
		it.addComponent(that);
		that.init(initializer)
		return that
	}

	static def label(ComponentContainer it, (Label)=>void initializer) {
		val that = new Label()
		it.addComponent(that)
		that.init(initializer)
		return that
	}

	static def button(ComponentContainer it, (Button)=>void initializer) {
		val that = new Button()
		it.addComponent(that)
		that.init(initializer)
		return that
	}
	
	static def text(ComponentContainer it, (TextField)=>void initializer) {
		val that = new TextField()
		it.addComponent(that)
		that.init(initializer)
		return that
	}
	
	static def password(ComponentContainer it, (PasswordField)=>void initializer) {
		val that = new PasswordField()
		it.addComponent(that)
		that.init(initializer)
		return that
	}
	
	static def image(ComponentContainer it, (Image)=>void initializer) {
		val that = new Image()
		it.addComponent(that)
		that.init(initializer)
		return that
	}
	
	static def table(ComponentContainer it, (Table)=>void initializer) {
		val that = new Table()
		it.addComponent(that)
		that.init(initializer)
		return that
	}
	
	static def combobox(ComponentContainer it, (ComboBox)=>void initializer) {
		val that = new ComboBox()
		it.addComponent(that)
		that.init(initializer)
		return that
	}

	static def private <T> T init(T obj, (T)=>void init) {
		init?.apply(obj)
		return obj
	}

}
