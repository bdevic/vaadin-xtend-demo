package net.croz.vaadinxtenddemo.views.dashboard

import com.vaadin.navigator.View
import com.vaadin.navigator.ViewChangeListener$ViewChangeEvent
import com.vaadin.server.Page
import com.vaadin.ui.Notification
import com.vaadin.ui.UI
import com.vaadin.ui.VerticalLayout
import com.vaadin.ui.Window
import com.vaadin.ui.themes.Reindeer
import java.text.SimpleDateFormat
import java.util.Calendar
import java.util.Date
import java.util.Random
import java.util.concurrent.Executors
import java.util.concurrent.TimeUnit
import java.util.concurrent.atomic.AtomicInteger
import javax.annotation.PostConstruct
import net.croz.vaadinxtenddemo.components.GenericEditComponent
import net.croz.vaadinxtenddemo.components.MainItem
import net.croz.vaadinxtenddemo.model.Expense
import org.springframework.context.annotation.Scope
import org.springframework.core.io.ClassPathResource
import org.springframework.stereotype.Component
import ru.xpoft.vaadin.VaadinView

import static extension net.croz.vaadinxtenddemo.api.BuilderExtensions.*
import static extension org.apache.commons.io.IOUtils.*

@Component
@Scope("prototype")
@VaadinView(DashboardView::NAME)
class DashboardView extends VerticalLayout implements View {

	public static val NAME = "Dashboard"
	val scheduler = Executors::newScheduledThreadPool(1)

	@PostConstruct
	def postConstruct() {
		this => [
			margin = true
			label [
				caption = "Welcome to the Vaadin Xtend Demo!"
				addStyleName = Reindeer::LABEL_H1
			]
			label [
				caption = "This screen is the main menu for Vaadin Xtend Demo. What would you like to do?"
				addStyleName = Reindeer::LABEL_SMALL
			]
			component(new MainItem("New input expense", "Creates a new input expense document")) [
				addLayoutClickListener [
					val expenseWnd = new Window("Input expense",  new GenericEditComponent(typeof(Expense), new Expense()))
					UI::current.addWindow(expenseWnd)
					expenseWnd.center
					expenseWnd.bringToFront
				]
			]
		]

	}

	@Override
	override attach() {
		super.attach()
		val ui = this.UI
		val quotes = new ClassPathResource("quotes.properties").inputStream.readLines
		val pushCounts = new AtomicInteger(0)
		val Runnable messager = [ |
			ui.access(
				[ |
					new Notification("Quote",
						notificationMessage(Calendar::instance.time, pushCounts.incrementAndGet,
							quotes.get(new Random().nextInt(quotes.size))).toString,
						Notification::TYPE_TRAY_NOTIFICATION, true).show(Page::current)
				]);
		]

		scheduler.scheduleAtFixedRate(messager, 30, 60, TimeUnit::SECONDS)
	}

	@Override
	override detach() {
		super.detach()

		scheduler.shutdown
	}

	def notificationMessage(Date date, int messages, String message) '''
		«message» <br/>
		<i>«new SimpleDateFormat("HH:mm:ss").format(date)» / Unread («messages»)</i>
	'''

	override enter(ViewChangeEvent event) {
	}

}
