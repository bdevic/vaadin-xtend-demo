package net.croz.vaadinxtenddemo.components

import com.vaadin.ui.VerticalLayout
import com.vaadin.ui.themes.Reindeer

import static extension net.croz.vaadinxtenddemo.api.BuilderExtensions.*

class MainItem extends VerticalLayout {

	new() {
	}

	new(String displayName, String description) {

		this => [
			margin = true
			setSizeUndefined()
			addStyleName = "mainMenuItem"
			label [
				caption = displayName
				addStyleName = Reindeer::LABEL_H2
			]
			label [
				caption = description
			]
		]
	}

}