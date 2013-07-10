package net.croz.vaadinxtenddemo.views.login

import com.vaadin.event.ShortcutAction$KeyCode
import com.vaadin.navigator.View
import com.vaadin.navigator.ViewChangeListener$ViewChangeEvent
import com.vaadin.server.ThemeResource
import com.vaadin.ui.Alignment
import com.vaadin.ui.Notification
import com.vaadin.ui.UI
import com.vaadin.ui.VerticalLayout
import com.vaadin.ui.themes.Reindeer
import javax.annotation.PostConstruct
import net.croz.vaadinxtenddemo.views.dashboard.DashboardView
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.context.annotation.Scope
import org.springframework.stereotype.Component
import ru.xpoft.vaadin.VaadinMessageSource
import ru.xpoft.vaadin.VaadinView

import static extension net.croz.vaadinxtenddemo.api.ApiExtensions.*
import static extension net.croz.vaadinxtenddemo.api.BuilderExtensions.*

@Component
@Scope("prototype")
@VaadinView()
class LoginView extends VerticalLayout implements View {
	public static val NAME = "Login"
	
	@Autowired
	extension VaadinMessageSource messages
 
	@PostConstruct
	def postConstruct() {
		this => [
			setSizeFull
			addStyleName = Reindeer::LAYOUT_BLACK
			verticalLayout [
				alignment(Alignment::MIDDLE_CENTER)
				spacing = true
				width = "300px"
				horizontalLayout [
					width = "100%"
					label [
						caption = "loginView.welcome".message
						addStyleName = Reindeer::LABEL_H1
					]
					image [
						alignment(Alignment::MIDDLE_RIGHT)
						icon = new ThemeResource("img/login.png")
					]
				]
				text [
					caption = "loginView.username".message
					width = "100%"
					focus
				]
				password [
					caption = "loginView.password".message
					width = "100%"
				]
				horizontalLayout [
					
					alignment(Alignment::MIDDLE_RIGHT)
					spacing = true
					button [
						caption = "loginView.login".message
						clickShortcut = KeyCode::ENTER
						addStyleName = Reindeer::BUTTON_DEFAULT
						addClickListener [
							UI::current.navigator.navigateTo(DashboardView::NAME)
						]
					]
					button [
						caption = "loginView.restart".message
						description = "loginView.restart.description".message
						addClickListener [
							Notification::show("loginView.restart.message".message, Notification::TYPE_TRAY_NOTIFICATION)
							UI::current.close
						]
					]
				]
			]
			
		]
	}

	override enter(ViewChangeEvent event) {
	}

}
