
using System;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.UI;

namespace AcademicLeaveSystem
{
    public partial class AcademicLeave : Page
    {
        private DataTable CalendarData
        {
            get
            {
                if (Session["CalendarData"] == null)
                {
                    DataTable dt = new DataTable();
                    dt.Columns.Add("Date");
                    dt.Columns.Add("Event");
                    dt.Columns.Add("Description");

                    dt.Rows.Add("2026-11-05", "Mid-Sem Exam",
                        "Mid-semester examination");
                    dt.Rows.Add("2026-12-15", "Project Submission",
                        "Final project submission");
                    dt.Rows.Add("2027-01-10", "Annual Fest",
                        "College cultural event");

                    Session["CalendarData"] = dt;
                }

                return (DataTable)Session["CalendarData"];
            }
        }

        private DataTable LeaveData
        {
            get
            {
                if (Session["LeaveData"] == null)
                {
                    DataTable dt = new DataTable();
                    dt.Columns.Add("Student ID");
                    dt.Columns.Add("Student Name");
                    dt.Columns.Add("Leave Type");
                    dt.Columns.Add("From Date");
                    dt.Columns.Add("To Date");
                    dt.Columns.Add("Reason");
                    dt.Columns.Add("Status");

                    Session["LeaveData"] = dt;
                }

                return (DataTable)Session["LeaveData"];
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindCalendar();
                BindLeaves();
            }
        }

        private void BindCalendar()
        {
            gvCalendar.DataSource = CalendarData;
            gvCalendar.DataBind();
        }

        private void BindLeaves()
        {
            gvLeaves.DataSource = LeaveData;
            gvLeaves.DataBind();
        }

        protected void btnApply_Click(object sender, EventArgs e)
        {
            Page.Validate();

            if (!Page.IsValid)
                return;

            DateTime fromDate, toDate;

            if (!DateTime.TryParse(txtFrom.Text, out fromDate) ||
                !DateTime.TryParse(txtTo.Text, out toDate))
            {
                ShowError("Please enter valid leave dates.");
                return;
            }

            if (toDate < fromDate)
            {
                ShowError("End date cannot be before start date.");
                return;
            }

            DataRow row = LeaveData.NewRow();
            row["Student ID"] = txtStudentId.Text.Trim();
            row["Student Name"] = txtName.Text.Trim();
            row["Leave Type"] = ddlLeaveType.SelectedItem.Text;
            row["From Date"] = fromDate.ToString("yyyy-MM-dd");
            row["To Date"] = toDate.ToString("yyyy-MM-dd");
            row["Reason"] = txtReason.Text.Trim();
            row["Status"] = "Pending";

            LeaveData.Rows.Add(row);
            BindLeaves();

            lblMessage.ForeColor = Color.Green;
            lblMessage.Text =
                "Leave application submitted successfully. Status: Pending.";

            txtName.Text = "";
            txtStudentId.Text = "";
            ddlLeaveType.SelectedIndex = 0;
            txtFrom.Text = "";
            txtTo.Text = "";
            txtReason.Text = "";
        }

        private void ShowError(string message)
        {
            lblMessage.ForeColor = Color.Red;
            lblMessage.Text = HttpUtility.HtmlEncode(message);
        }
    }
}
