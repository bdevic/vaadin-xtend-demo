package net.croz.vaadinxtenddemo.ui

import com.vaadin.annotations.Push
import com.vaadin.annotations.Theme
import com.vaadin.annotations.Title
import com.vaadin.navigator.ViewChangeListener
import com.vaadin.server.Page
import com.vaadin.server.ThemeResource
import com.vaadin.server.VaadinRequest
import com.vaadin.shared.ui.MarginInfo
import com.vaadin.shared.ui.label.ContentMode
import com.vaadin.ui.Alignment
import com.vaadin.ui.Component
import com.vaadin.ui.PopupView
import com.vaadin.ui.TabSheet
import com.vaadin.ui.UI
import com.vaadin.ui.VerticalLayout
import com.vaadin.ui.themes.Reindeer
import net.croz.vaadinxtenddemo.util.ViewDiscoveryNavigator
import net.croz.vaadinxtenddemo.views.login.LoginView
import org.springframework.context.annotation.Scope

import static extension net.croz.vaadinxtenddemo.api.ApiExtensions.*
import static extension net.croz.vaadinxtenddemo.api.BuilderExtensions.*
import com.vaadin.navigator.ViewChangeListener$ViewChangeEvent

@Title("Vaadin XTend Demo")
@Theme("crozcon")
@org.springframework.stereotype.Component
@Scope("prototype")
@Push
class DemoUI extends UI {

	var VerticalLayout root
	var VerticalLayout navigation
	var VerticalLayout view
	var VerticalLayout viewPlaceholder
	var ViewDiscoveryNavigator nav
	var PopupView popup

	override protected init(VaadinRequest request) {
		setSizeFull
		content = root = new VerticalLayout() => [
			setSizeFull
		]
		view = new VerticalLayout() => [
			setSizeFull
		]

		nav = new ViewDiscoveryNavigator(this, view)
		buildNavigation
		nav.addViewChangeListener = new UIViewChangeListener(root, navigation, viewPlaceholder)

	}

	def buildNavigation() {
		navigation = new VerticalLayout() => [
			margin = false
			horizontalLayout [
				width = "100%"
				spacing = true
				margin = new MarginInfo(false, false, true, false)
				addStyleName = Reindeer::LAYOUT_BLACK
				image [
					icon = new ThemeResource("img/vaadin.png");
				]
				verticalLayout[
					alignment(Alignment::BOTTOM_LEFT)
					expandRatio(1.0F)
					label [
						caption = "Vaadin with Xtend Demo"
						addStyleName = Reindeer::LABEL_H1
					]
					label [
						caption = "Version 0.0.0.0.1"
						addStyleName = Reindeer::LABEL_SMALL
					]
				]
				button [
					alignment(Alignment::BOTTOM_RIGHT)
					caption = "My messages"
					addClickListener [popup.setPopupVisible(true)]
				]
				component(buildPopup("Quote: Software sucks because users demand it to."))[
					popup = it
				]
				button [
					alignment(Alignment::BOTTOM_RIGHT)
					caption = "Refresh"
					addClickListener(
						[
							Page::current.uriFragment = Page::current.uriFragment + "/"
						])
				]
				button [
					alignment(Alignment::BOTTOM_RIGHT)
					caption = "Logout"
					addClickListener [UI::current.navigator.navigateTo("")]
				]
			]
			component(typeof(TabSheet)) [
				nav.viewDescriptions.filter[!it.name.nullOrEmpty].forEach [ view |
					addTab(new VerticalLayout(), view.name)
				]
				addSelectedTabChangeListener [ e |
					UI::current.navigator.navigateTo(it.getTab(e.tabSheet.selectedTab).caption)
				]
			]
			verticalLayout [
				setSizeFull
				viewPlaceholder = it
			]
		]
	}

	def buildPopup(String message) {
		popup = new PopupView("", new VerticalLayout() => [
			setSizeUndefined
			margin = false
			spacing = true
			label [
				caption = message
				contentMode = ContentMode::HTML
			]
			button [
				alignment(Alignment::BOTTOM_RIGHT)
				caption ="Mark read"
				addStyleName = Reindeer::BUTTON_SMALL
				addClickListener [popup.setPopupVisible(false)]
			]
		])
	}
}

class UIViewChangeListener implements ViewChangeListener {

	val VerticalLayout root
	val VerticalLayout navigation
	val VerticalLayout viewPlaceholder

	new(VerticalLayout root, VerticalLayout navigation, VerticalLayout viewPlaceholder) {
		this.root = root
		this.navigation = navigation
		this.viewPlaceholder = viewPlaceholder
	}

	override afterViewChange(ViewChangeEvent event) {
		if (event.newView instanceof LoginView) {
			root.removeAllComponents
			root.addComponent(event.newView as Component)

		} else {
			root.removeAllComponents
			viewPlaceholder.removeAllComponents
			viewPlaceholder.addComponent = event.newView as Component
			root.addComponent(navigation)
		}
	}

	override beforeViewChange(ViewChangeEvent event) {

		return true
	}

}
